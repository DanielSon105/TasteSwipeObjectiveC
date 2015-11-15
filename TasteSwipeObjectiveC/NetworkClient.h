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

- (NSArray *)loadGroceryListFromCache;

@end
