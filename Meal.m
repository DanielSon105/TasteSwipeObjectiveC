//
//  Meal.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/10/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "Meal.h"

@implementation Meal

- (instancetype)initMealWithContentsOfDictionary:(NSDictionary *)mealDictionary
{
    self = [super init];
    if(self)
    {
        self.mealID = [mealDictionary objectForKey:@"id"];
        self.mealName = [mealDictionary objectForKey:@"name"];
        self.mealDescription =[mealDictionary objectForKey:@"description"];
        self.mealImageURL = [mealDictionary objectForKey:@"image_url"];
        self.calories = [mealDictionary objectForKey:@"calories"];
        self.proteinGrams = [mealDictionary objectForKey:@"protein_grams"];
        self.carbohydrateGrams = [mealDictionary objectForKey:@"carbohydrate_grams"];
        self.fatGrams = [mealDictionary objectForKey:@"fat_grams"];
        self.fatGrams = [mealDictionary objectForKey:@"category"];
        self.mealConsumablesArray = [mealDictionary objectForKey:@"consumables"];
    }

    return self;
}

-(void)updateToTryList{
    
}

-(void)postMealToToTryList:(NSString *)accessToken{
    //do this for meals you swipe right on
//    NSString *cachedToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"];

    // Create the request.
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tasteswipe-int.herokuapp.com/meal/%@/right",self.mealID]]];

    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";

    // Set Header Fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", accessToken] forHTTPHeaderField:@"Authorization"];

    NSLog(@"Token token=\"%@\"; charset=utf-8", accessToken);


    // Convert data and set request's HTTPBody property
    //    NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:self.mealID, @"email", password, @"password", passwordConfirmation, @"password_confirmation", nil];
    //    NSArray *tmp = user.toTryMealArray;

    NSError *error;
    //    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
    //    [request setHTTPBody:postdata];

    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        //do stuff

        //IF e-mail has been taken --> populate error label "email has been taken"

        //IF password is too short --> populate error label "password is too short"

        //IF passwords don't match --> populate error label "passwords don't match"

        //ELSE return token  --> set user.token = returnedTokenString


        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            NSLog(@"Response --> %@", response);
            if (httpResp.statusCode == 200) {
                // 3
                NSString *text =
                [[NSString alloc]initWithData:data
                                     encoding:NSUTF8StringEncoding];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    NSLog(@"%@", text);
                    //                    [user.toTryMealArray addObject:self.mealID];


                    //set u
                });

            } else {
                NSLog(@"Swipe Right didn't work");
                // HANDLE BAD RESPONSE //
            }
        } else {
            // ALWAYS HANDLE ERRORS :-] //
        }
        // 4
        
    }];
    [postDataTask resume];
    
}

-(void)deleteMealFromToTryList{

}

-(void)postMealToDisinterestedList:(NSString *)accessToken{
    //do this for meals you swipe left on
    NSString *cachedToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"];
    // Create the request.
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tasteswipe-int.herokuapp.com/meal/%@/left",self.mealID]]];

    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";

    // Set Header Fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", cachedToken] forHTTPHeaderField:@"Authorization"];

    NSLog(@"Token token=\"%@\"; charset=utf-8", cachedToken);


    // Convert data and set request's HTTPBody property
    //    NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:self.mealID, @"email", password, @"password", passwordConfirmation, @"password_confirmation", nil];
    //    NSArray *tmp = user.toTryMealArray;

    NSError *error;
    //    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
    //    [request setHTTPBody:postdata];

    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            NSLog(@"Response --> %@", response);
            if (httpResp.statusCode == 200) {
                // 3
                NSString *text =
                [[NSString alloc]initWithData:data
                                     encoding:NSUTF8StringEncoding];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    NSLog(@"%@", text);
                    //                    [user.toTryMealArray addObject:self.mealID];


                    //set u
                });

            } else {
                NSLog(@"Swipe Left didn't work");
                // HANDLE BAD RESPONSE //
            }
        } else {
            // ALWAYS HANDLE ERRORS :-] //
        }
        // 4
        
    }];
    [postDataTask resume];
    
}


@end
