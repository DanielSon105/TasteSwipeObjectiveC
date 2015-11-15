//
//  GroceryListViewController.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/11/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroceryListViewController : UIViewController

@property NSArray *groceries;

- (void)loadData;

@end
