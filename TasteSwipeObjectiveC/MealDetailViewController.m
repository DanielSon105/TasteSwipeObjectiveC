//
//  MealDetailViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/11/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "MealDetailViewController.h"
#import "ConsumableTableViewCell.h"
#import "RecipeViewController.h"

@interface MealDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *mealImage;
@property (weak, nonatomic) IBOutlet UITableView *consumbleTableView;
@property NSMutableArray *consumablesArray;
@property Consumable *selectedConsumable;

@end

@implementation MealDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.meal.mealImageURL]];
    self.mealImage.image = [UIImage imageWithData:imageData];
    self.consumablesArray = [NSMutableArray new];
    for (NSDictionary *dict in self.meal.mealConsumablesArray) {
        Consumable *consumable = [[Consumable alloc] initConsumableWithJSON:dict];
        [self.consumablesArray addObject:consumable];
    }

    // Pass in Consumables from previous VC?  OR load consumables based on passed in meal?... leaning towards the latter
    NSLog(@"%@", self.meal);
    NSLog(@"%@", self.meal.mealName);
    // Do any additional setup after loading the view.
}

#pragma mark - Consumables Tableview Cell Datasource and Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.consumablesArray.count;
}

-(ConsumableTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsumableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsumableCell"];
    cell.consumable = [self.consumablesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cell.consumable.consumableName;
    NSLog(@"Cell Consumable Info --> %@", cell.consumable);
//    cell.imageView.image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:cell.toTryListMeal.mealImageURL]]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedConsumable = [self.consumablesArray objectAtIndex:indexPath.row]; // make sure this is the correct array
    NSLog(@"self.selected Consumable didSelectRow --> %@", self.selectedConsumable);
    [self performSegueWithIdentifier: @"ConsumablesToRecipeSegue" sender:self];

}

#pragma mark - Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //ConsumablesToRecipeSegue

    if ([segue.identifier isEqual: @"ConsumablesToRecipeSegue"]) {
//       RecipeViewController *rvc = segue.destinationViewController;




        UINavigationController *recipeNavigationController = segue.destinationViewController;
        RecipeViewController *rvc = [recipeNavigationController.childViewControllers objectAtIndex:0];
        NSLog(@"%@", recipeNavigationController.childViewControllers);
        rvc.consumable = self.selectedConsumable;
//        NSLog(@"%@", self.selectedConsumable.recipeID);
//        if (self.selectedConsumable.recipeID == NULL) {
//            rvc.hasRecipeID = YES;
//        }
    }

}



//-(NSURL *)documentsDirectory {
//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
//
//}


//-(void)save {
//    NSURL *pList = [[self documentsDirectory] URLByAppendingPathComponent:@"toTryListMeals.plist"];
//    [self.toTryListMeals writeToURL:pList atomically:YES];
//    NSLog(@"%@", pList);
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:[NSDate date] forKey:@"LastWriteDate"];
//}
//
//-(void)load {
//    NSURL *pList = [[self documentsDirectory] URLByAppendingPathComponent:@"toTryListMeals.plist"];
//    self.toTryListMeals = [NSMutableArray arrayWithContentsOfURL:pList];
//}

@end
