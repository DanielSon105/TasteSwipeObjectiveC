//
//  ToTryListTableViewCell.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/12/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

@protocol ToTryListTableViewCellDelegate <NSObject>

-(void)foodTableViewCell:(id)cell didTap:(id)button; //declared a method in our protocol

@end

@interface ToTryListTableViewCell : UITableViewCell

@property Meal *toTryListMeal;

@property (nonatomic,assign)id<ToTryListTableViewCellDelegate>delegate; //declared a property of type 'id' that specified the protocol

@end
