//
//  Meal.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/10/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"

@interface Meal : NSObject

- (instancetype)initMealWithContentsOfDictionary:(NSDictionary *)mealDictionary;

@property NSString *mealID;
@property NSString *mealName;
@property NSString *mealDescription;
@property NSString *mealImageURL;
@property NSArray *mealConsumablesArray;

-(void)postMealToToTryList:(User *)user;
-(void)deleteMealFromToTryList;

-(void)postMealToDisinterestedList;
-(void)deleteMealFromDisinterestedList;


@end
