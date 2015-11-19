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

@interface GroceryListViewController () <UITabBarDelegate, UITableViewDataSource, UITextFieldDelegate>
@property NetworkClient *networkClient;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *groceryListItems;

@property (weak, nonatomic) IBOutlet UIButton *addOrEditButton;
@property (weak, nonatomic) IBOutlet UITextField *ingredientTextField;
@property (weak, nonatomic) IBOutlet UITextField *unitOfMeasurementTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

@property GroceryListItem *selectedGroceryListItem;


@end

@implementation GroceryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ingredientTextField.delegate=self;
    self.unitOfMeasurementTextField.delegate=self;
    self.amountTextField.delegate=self;
    self.networkClient = [NetworkClient new];
    self.groceries = [self.networkClient loadGroceryListFromCache];
    self.groceryListItems = [NSMutableArray new];
    for (NSDictionary *dict in self.groceries) {
        GroceryListItem *item = [[GroceryListItem alloc] initWithJSON:dict];
        [self.groceryListItems addObject:item];
    }
    self.selectedGroceryListItem = [GroceryListItem new];
//    [self load];
    NSLog(@"Groceries --> %@",self.groceries);
    NSLog(@"Grocery List Items ---> %@", self.groceryListItems);
    //Load the grocery list Plist on this view Controller

    [self loadData];
}
-(NSURL *)documentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];

}

-(void)save {
    NSURL *pList = [[self documentsDirectory] URLByAppendingPathComponent:@"GroceryList.plist"];
    [self.groceryListItems writeToURL:pList atomically:YES];
    NSLog(@"%@", pList);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSDate date] forKey:@"LastWriteDate"];
}
//
//-(void)load {
//    NSURL *pList = [[self documentsDirectory] URLByAppendingPathComponent:@"GroceryList.plist"];
//    self.groceryListItems = [NSMutableArray arrayWithContentsOfURL:pList];
//}



- (void)loadData {
    self.groceries = [self.networkClient loadGroceryListFromCache];
    NSLog(@"******Looking for items !!!!!!!!");

    //need to update logic in NetworkClient.h/m  ... and this is dependent on 1) the user.. (indirectly....basically, if a different user logs on to the app, the current Plist has to be erased....) 2) adding something from the Consumables VC.
}

#pragma mark - Tableview Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groceryListItems.count;
}

-(GroceryListItemTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroceryListItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroceryListItemTableViewCell"];

    cell.groceryListItem = [self.groceryListItems objectAtIndex:indexPath.row];
    cell.textLabel.text = cell.groceryListItem.ingredient;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Amount: %@ Unit of Measurement: %@", cell.groceryListItem.amount, cell.groceryListItem.unitOfMeasurement];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    self.selectedGroceryListItem = [self.groceryListItems objectAtIndex:indexPath.row];
    self.ingredientTextField.text = self.selectedGroceryListItem.ingredient;
    self.amountTextField.text = self.selectedGroceryListItem.amount;
    self.unitOfMeasurementTextField.text = self.selectedGroceryListItem.unitOfMeasurement;
}
- (IBAction)onAddEditButtonTapped:(id)sender {
    GroceryListItem *newItem = [GroceryListItem new];
    newItem.amount = self.amountTextField.text;
    newItem.ingredient = self.ingredientTextField.text;
    newItem.unitOfMeasurement = self.amountTextField.text;

    [self.groceryListItems addObject:newItem];
    [self.tableView reloadData];
    //SAVE PLIST
}






//    if ([self.addOrEditButton.titleLabel.text isEqualToString:@"Update"]) {
//        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.ingredientTextField.text, @"ingredient", self.amountTextField.text, @"amount", self.unitOfMeasurementTextField.text, @"unit", nil];
//        GroceryListItem *newItem = [[GroceryListItem alloc] initWithJSON:dict];
////        [self loadData];
//        NSMutableArray *updatedGroceries = [self.groceryListItems copy];
//        [updatedGroceries removeObjectAtIndex:self.tableView.indexPathForSelectedRow.row];
//        [updatedGroceries addObject:newItem];
//        self.groceryListItems = updatedGroceries;
//        [self.tableView reloadData];
//
//
////        [self.networkClient saveGroceryListToCache:updatedGroceries];
////        NSMutableArray *tmpArray = [NSMutableArray new];
////        for (NSDictionary *dict in updatedGroceries) {
////            GroceryListItem *item = [[GroceryListItem alloc] initWithJSON:dict];
////            [tmpArray addObject:item];
////        }
////        self.groceryListItems = tmpArray;
////        [self.tableView reloadData];
//    }
//}

#pragma mark - Keyboard Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -250; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed

    int movement = (up ? movementDistance : -movementDistance);

    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
@end
