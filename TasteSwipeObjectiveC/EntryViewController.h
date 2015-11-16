//
//  EntryViewController.h
//  TasteSwipeObjectiveC
//
//  Created by Michelle Burke on 11/16/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipe;
@class RecipeStep;

@interface EntryViewController : UIViewController

//@property Recipe *recipeDirections;
@property RecipeStep *step;
@property NSInteger page;

-(void)loadEntry;

@end
