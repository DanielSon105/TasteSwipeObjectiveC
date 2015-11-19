//
//  RecipeViewController.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/11/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Consumable.h"
#import "Meal.h"


@interface RecipeViewController : UIViewController
@property Consumable *consumable;
@property Meal *meal;
@property BOOL hasRecipeID;


@end
