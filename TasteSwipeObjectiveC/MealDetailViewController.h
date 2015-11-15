//
//  MealDetailViewController.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/11/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "Consumable.h"
#import "User.h"

@interface MealDetailViewController : UIViewController
@property NSArray *consumables;
@property Meal *meal;

@end
