//
//  ToTryListViewController.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/10/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Meal.h"
#import "ToTryListTableViewCell.h"

@interface ToTryListViewController : UIViewController

-(void)loadToTryListFromJSON;

@end
