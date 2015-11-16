//
//  ConsumableIngredientTableViewCell.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/14/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "ConsumableIngredientTableViewCell.h"

@implementation ConsumableIngredientTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)onGroceryListButtonTapped:(id)sender{
    //Populate Alert View that asks for confirmation.... IF you confirm then add Grocery List Item to Array of Grocery List Items and update PList... meaning... we have to load the grocery list Plist on this view Controller... NOTE: we also need to send either the grocery list array OR the PList File through the prepare for segue to the Grocery List VC
}

@end
