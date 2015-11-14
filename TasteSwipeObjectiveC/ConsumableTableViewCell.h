//
//  ConsumableTableViewCell.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/13/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h" //may be unecessary
#import "Consumable.h"

@interface ConsumableTableViewCell : UITableViewCell
@property Consumable *consumable;

@property NSInteger *consumableID;
@property NSString *name;
@property NSString *consumableDescription;
@property NSString *imageURL;
@property NSMutableArray *ingredientIDs;




@end
