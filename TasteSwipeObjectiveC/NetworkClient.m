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

- (NSArray *)loadGroceryListFromCache {
    NSFileManager *fileManager = [NSFileManager new];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"GroceryList.plist"];

    if ([fileManager fileExistsAtPath:path]) {
        NSArray * groceries = [[NSArray alloc] initWithContentsOfFile:path];
        NSMutableArray *groceryListArray = [NSMutableArray new];
        for (NSDictionary *json in groceries) {
            GroceryListItem *item = [[GroceryListItem alloc] initWithJSON:json]; //
//            [self loadImageFromURL:meal]; // we don't have images for individual items yet... not sure if we ever will? perhaps Nutritionix API will
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

@end
