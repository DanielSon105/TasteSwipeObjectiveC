//
//  MealDetailScrollingViewController.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/18/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"
#import "Consumable.h"
#import "User.h"

@interface MealDetailScrollingViewController : UIViewController
@property NSArray *consumables;
@property Meal *meal;
@property (weak, nonatomic) IBOutlet UINavigationItem *mealDetailNavigationItem;

@end
