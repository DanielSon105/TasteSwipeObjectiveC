//
//  NetworkClient.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/13/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "NetworkClient.h"
#import "Meal.h"
#import "User.h"
#import "GroceryListItem.h"

@implementation NetworkClient

//+(NSString*)apiAuthorizationHeader
//{
//    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"];
//    return [self plainTextAuthorizationHeaderForToken:token];
//}

//+(NSString*)plainTextAuthorizationHeaderForToken:(NSString*)token
//{
//    NSString *authorizationHeaderValue = [NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", token];
//    return authorizationHeaderValue;
//}

#pragma mark - deployed URLs

+ (NSURL*)signupURL
{
    NSString *url = @"http://tasteswipe-int.herokuapp.com/registration";
    return [NSURL URLWithString:url];
}

+ (NSURL*)loginURL
{
    NSString *url = @"http://tasteswipe-int.herokuapp.com/tokens";
    return [NSURL URLWithString:url];
}

+ (NSURL*)logoutURL
{
    NSString *url = @"http://tasteswipe-int.herokuapp.com/tokens";
    return [NSURL URLWithString:url];
}

+ (NSURL*)showCurrentMealURL
{
    NSString *url = @"http://tasteswipe-int.herokuapp.com/meal";
    return [NSURL URLWithString:url];
}

+ (NSURL*)swipeRightURL:(NSString *)mealID
{
    NSString *url = [NSString stringWithFormat:@"http://tasteswipe-int.herokuapp.com/meal/%@/right", mealID];
    return [NSURL URLWithString:url];
}

+ (NSURL*)swipeLeftOrRemoveMealFromTryListURL:(NSString *)mealID
{
    NSString *url = [NSString stringWithFormat:@"http://tasteswipe-int.herokuapp.com/meal/%@/left", mealID];
    return [NSURL URLWithString:url];
}

+ (NSURL*)listOfRandomMealsURL
{
    NSString *url = @"http://tasteswipe-int.herokuapp.com/random_meals";
    return [NSURL URLWithString:url];
}

+ (NSURL*)showIngredientURL:(NSString *)ingredientID;
{
    NSString *url = [NSString stringWithFormat:@"http://tasteswipe-int.herokuapp.com/ingredient/%@", ingredientID];
    return [NSURL URLWithString:url];
}

+ (NSURL*)listOfMealsToTryURL
{
    NSString *url = @"http://tasteswipe-int.herokuapp.com/try_meals";
    return [NSURL URLWithString:url];
}

#pragma mark - backlogged URLs

//Tried a Meal      POST /meal/:meal_id/tried
//Rate a Meal       POST /meal/:meal_id/rated

//List Tried Meals	GET /tried_meals
//Get Recipe        GET /recipe/:recipe_id

//Rate Meal         POST /meal/:meal_id/rate
//Comment on Meal	POST /meal/:meal_id/comment

#pragma mark - Grocery List Stuff


- (NSArray *)loadGroceryListFromCache {
    NSFileManager *fileManager = [NSFileManager new];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"GroceryList.plist"];

    if ([fileManager fileExistsAtPath:path]) {
        NSArray * groceries = [[NSArray alloc] initWithContentsOfFile:path];
        NSMutableArray *groceryListArray = [NSMutableArray new];
        for (NSDictionary *json in groceries) {
            GroceryListItem *item = [[GroceryListItem alloc] initWithJSON:json]; //
            [groceryListArray addObject:item];
        }

        return groceryListArray;
    }

    return nil;
}

- (void)saveGroceryListToCache:(NSArray *)groceries {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"GroceryList.plist"];

    NSMutableArray *groceryListArray = [NSMutableArray new];
    for (GroceryListItem *item in groceries) {
        NSMutableDictionary *d = [NSMutableDictionary new];
        d[@"name"] = item.ingredient;
        d[@"amount"] = item.amount;
        d[@"unitOfMeasurement"] = item.unitOfMeasurement;
        [groceryListArray addObject:d];
    }

    [groceryListArray writeToFile:path atomically:true];
}

#pragma mark - Currently basically a copy and paste job from SuperHeropedia that is halfway converted to Something Useful for Taste Swipe :-)

- (void)loadDataFromURL:(NSString *)urlString completionHandler:(void (^)(NSArray *heroes))completionHander {
    NSURL *url = [NSURL URLWithString:urlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"ERROR :: NetworkClient#loadDataFromURL");
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray * heroes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSMutableArray *superheroes = [NSMutableArray new];
                for (NSDictionary *json in heroes) {
                    //                    Superhero *hero = [[Superhero alloc] initWithJSON:json];
                    //                    [self loadImageFromURL:hero];
                    //                    [superheroes addObject:hero];
                }
                completionHander(superheroes);
            });
        }
    }] resume];
}

- (void)loadImageFromURL:(Meal *)meal {
    NSFileManager *fileManager = [NSFileManager new];
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePathToWrite = [NSString stringWithFormat:@"%@/%@.png", paths, meal.mealName];
    if (![fileManager fileExistsAtPath:filePathToWrite isDirectory:nil]) {
        NSURL *url = [NSURL URLWithString:meal.mealImageURL];
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"ERROR :: NetworkClient#loadImageFromURL");
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                    UIImage *image = [UIImage imageWithData:data];
                    //                    NSData *imageData = UIImagePNGRepresentation(image);
                    //                    [fileManager createFileAtPath:filePathToWrite contents:imageData attributes:nil];
                });
            }
        }] resume];
    }
}

- (UIImage *)loadImageFromCache:(Meal *)meal {
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) objectAtIndex:0];
    NSString *filePathToWrite = [NSString stringWithFormat:@"%@/%@.png", paths, meal.mealName];
    return [UIImage imageWithContentsOfFile:filePathToWrite];
}

//- (NSString *)loadUserFromCache{
//    NSFileManager *fileManager = [NSFileManager new];
//    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDoc, <#NSSearchPathDomainMask domainMask#>, <#BOOL expandTilde#>)]
//
//}

#pragma mark - One Get, One Post, One Delete...

//GET

//-(void)getMealInfo:(NSString *)token
//{
//    NSURLSessionConfiguration *sessionConfig =
//    [NSURLSessionConfiguration defaultSessionConfiguration];
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
//
//    NSURL *url = [NSURL URLWithString:@"http://tasteswipe-int.herokuapp.com/random_meals"];
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//
//    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
//    [request setValue:[NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", token] forHTTPHeaderField:@"Authorization"];
//
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        if (error != nil) {
//            NSLog(@"---> ERROR :: %@", error);
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            //            self.user.token = token; //THIS IS JUST HERE UNTIL I FIND A BETTER WAY TO GO ABOUT MANAGING THE TOKEN STUFF.
//
//            getMealDictionaryJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//            arrayOfMealDictionaries = [getMealDictionaryJSON objectForKey:@"meals"];
//            NSLog(@"%@",arrayOfMealDictionaries);
//            self.randomJSONMeals = [NSMutableArray new];
//            for (NSDictionary *dict in arrayOfMealDictionaries) {
//                Meal *meal = [[Meal alloc] initMealWithContentsOfDictionary:dict];
//                [self.randomJSONMeals addObject:meal];
//            }
//            loadedCards = [[NSMutableArray alloc] init];
//            allCards = [[NSMutableArray alloc] init];
//            cardsLoadedIndex = 0;
//            [self loadCards];
//        });
//    }];
//    [task resume];
//}

//POST

//-(void)postMealToDisinterestedList:(User *)user{
//    //do this for meals you swipe left on
//    NSString* token = @"jBDN0mkWbvHLUKqqRA6v";
//
//    // Create the request.
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tasteswipe-int.herokuapp.com/meal/%@/left",self.mealID]]];
//
//    // Specify that it will be a POST request
//    request.HTTPMethod = @"POST";
//
//    // Set Header Fields
//    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
//    [request setValue:[NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", token] forHTTPHeaderField:@"Authorization"];
//
//
//    // Convert data and set request's HTTPBody property
//    //    NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:self.mealID, @"email", password, @"password", passwordConfirmation, @"password_confirmation", nil];
//    //    NSArray *tmp = user.toTryMealArray;
//
//    NSError *error;
//    //    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
//    //    [request setHTTPBody:postdata];
//
//    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
//        if (!error) {
//            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
//            NSLog(@"Response --> %@", response);
//            if (httpResp.statusCode == 200) {
//                // 3
//                NSString *text =
//                [[NSString alloc]initWithData:data
//                                     encoding:NSUTF8StringEncoding];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//                    NSLog(@"%@", text);
//                    //                    [user.toTryMealArray addObject:self.mealID];
//
//
//                    //set u
//                });
//
//            } else {
//                NSLog(@"Sign-up didn't work");
//                // HANDLE BAD RESPONSE //
//            }
//        } else {
//            // ALWAYS HANDLE ERRORS :-] //
//        }
//        // 4
//        
//    }];
//    [postDataTask resume];
//    
//}


//DELETE



@end
