//
//  GroceryListViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/11/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "GroceryListViewController.h"
#import "NetworkClient.h"
#import "GroceryListItemTableViewCell.h"

@interface GroceryListViewController () <UITabBarDelegate, UITableViewDataSource>
@property NetworkClient *networkClient;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation GroceryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkClient = [NetworkClient new];
    self.groceries = [self.networkClient loadGroceryListFromCache];
    NSLog(@"%@",self.groceries);
    //Load the grocery list Plist on this view Controller

//    [self loadData];
}

- (void)loadData {
    self.groceries = [self.networkClient loadGroceryListFromCache]; //need to update logic in NetworkClient.h/m  ... and this is dependent on 1) the user.. (indirectly....basically, if a different user logs on to the app, the current Plist has to be erased....) 2) adding something from the Consumables VC.
}

#pragma mark - Tableview Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groceries.count;
}

-(GroceryListItemTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroceryListItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroceryListItemTableViewCell"];
        cell.groceryListItem = [self.groceries objectAtIndex:indexPath.row];
    cell.textLabel.text = cell.groceryListItem.ingredient;
    cell.detailTextLabel.text = cell.groceryListItem.amount;
    return cell;

}

@end
