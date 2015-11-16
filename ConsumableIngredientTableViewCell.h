//
//  ConsumableIngredientTableViewCell.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/14/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsumableIngredient.h"

@interface ConsumableIngredientTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *customMainLabel;
@property (weak, nonatomic) IBOutlet UILabel *customDetailLabel;
@property (weak, nonatomic) IBOutlet UIButton *groceryListButton;
@property ConsumableIngredient *consumableIngredient;

@end
