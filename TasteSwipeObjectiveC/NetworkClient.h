//
//  NetworkClient.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/13/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Meal;
@class User;

@interface NetworkClient : NSObject
@property NSString *accessToken;

//+(NSString*)apiAuthorizationHeader;
- (NSArray *)loadGroceryListFromCache;
- (void)saveGroceryListToCache:(NSArray *)groceries;

@end
