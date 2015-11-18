//
//  RecipeViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/11/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "RecipeViewController.h"
#import "ConsumableIngredientTableViewCell.h"
#import "ConsumableIngredient.h"
#import "NetworkClient.h"
#import "RecipeCookingViewController.h"
#import "GroceryListItem.h"

@interface RecipeViewController () <UITableViewDataSource, UITableViewDelegate>

@property NetworkClient *networkClient;

@property (weak, nonatomic) IBOutlet UITableView *ingredientsTableView;
@property NSArray *consumableIngredients;
@property NSMutableArray *ingredients;
@property NSMutableArray *groceryListItems;
@property ConsumableIngredient *selectedIngredient;


@property (weak, nonatomic) IBOutlet UIButton *showRecipeButton;

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showRecipeButton.hidden = YES;
    self.networkClient = [NetworkClient new];

    //Load the grocery list Plist on this view Controller...I think needs to be done on adding G-List though... moving it right now




    self.consumableIngredients = self.consumable.consumableIngredients;
    self.ingredients = [NSMutableArray new];
    for (NSDictionary *dict in self.consumableIngredients) {
        ConsumableIngredient *consumableIngredient = [[ConsumableIngredient alloc] initConsumableIngredientWithJSON:dict];
        [self.ingredients addObject:consumableIngredient];
    }



}

#pragma mark - Consumable Ingredient Tableview Delegate Methods

-(ConsumableIngredientTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsumableIngredientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsumableIngredientTableViewCell"];
    cell.consumableIngredient = [self.ingredients objectAtIndex:indexPath.row];

    cell.customMainLabel.text = cell.consumableIngredient.ingredientName;
    cell.customDetailLabel.text = [NSString stringWithFormat:@"Amount: %@ %@", cell.consumableIngredient.ingredientID, cell.consumableIngredient.ingredientDescription];

    cell.groceryListButton.tag = indexPath.row;
    [cell.groceryListButton addTarget:self action:@selector(onGroceryListButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    self.consumableIngredients
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ingredients.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIngredient = [self.ingredients objectAtIndex:indexPath.row];

}

-(void)onGroceryListButtonTapped:(id)sender{
    UIButton *senderButton = (UIButton *)sender;
    NSLog(@"Current Row --> %ld", (long)senderButton.tag);
    self.selectedIngredient = [self.ingredients objectAtIndex:senderButton.tag];
    NSLog(@"Selected Ingredient --> %@", self.selectedIngredient.ingredientName);

    if (self.selectedIngredient.addedToCart == YES) {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You have already added this ingredient to your grocery list." message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *addToGroceryList = [UIAlertAction actionWithTitle:@"Add another instance" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            senderButton.imageView.image = [UIImage imageNamed:@"shopping_cart_loaded"];
            //        [self.moc save:nil]; //save to Plist

        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Blue" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }];
        [alertController addAction:addToGroceryList];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You have chosen to add this ingredient to your list!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *addToGroceryList = [UIAlertAction actionWithTitle:@"Add To Grocery List" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            [self load];

            senderButton.imageView.image = [UIImage imageNamed:@"shopping_cart_loaded"];

//            self.groceryListItems = [NSMutableArray arrayWithArray:[self.networkClient loadGroceryListFromCache]];

            NSLog(@"self.groceryListItems BEFORE--> %@", self.groceryListItems);

            self.selectedIngredient.addedToCart = YES;

            NSLog(@"Selected Ingredient: %@, Amount: %@, Unit of Measurement: %@",self.selectedIngredient.ingredientName, self.selectedIngredient.amount, self.selectedIngredient.unitOfMeasurement);

            if ([self.selectedIngredient.unitOfMeasurement isEqual:[NSNull null]]) {
                self.selectedIngredient.unitOfMeasurement = @"N/A";
            }
            
            if ([self.selectedIngredient.amount isEqual:[NSNull null]]) {
                self.selectedIngredient.amount = @"N/A";
            }

            NSLog(@"Selected Ingredient: %@, Amount: %@, Unit of Measurement: %@",self.selectedIngredient.ingredientName, self.selectedIngredient.amount, self.selectedIngredient.unitOfMeasurement);

#warning using placeholder for amount and unit of measurement right now so change after Charlie uploads real data {


            //Only Solution is that you have to check all the NULL Values and Replace it with @" "
            NSDictionary *tmpDict = [[NSDictionary alloc] initWithObjectsAndKeys:self.selectedIngredient.ingredientName, @"ingredient", self.selectedIngredient.amount, @"amount", self.selectedIngredient.unitOfMeasurement, @"unit", nil];
#warning blah }
            [self.groceryListItems addObject:tmpDict];
            dispatch_after(0.2, dispatch_get_main_queue(), ^{
                [self save];
            });

//            NSArray *tmpArray = [NSArray arrayWithArray:self.groceryListItems];


//            [self.networkClient saveGroceryListToCache:tmpArray];

            //Anticipated Issue: Arrays cannot take in 2 of the same object, so we need to essentially ID the object based on its array Index


            //        [self.moc save:nil]; //save to Plist

        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Blue" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //        [self.moc save:nil];
        }];
        [alertController addAction:addToGroceryList];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];

        //Click Grocery Cart to add it to your grocery List ... Icon Changes?

        //Populate Alert View that asks for confirmation
        //IF you confirm then add Grocery List Item to Array of Grocery List Items and update PList

        //NOTE: we also need to send either the grocery list array OR the PList File through the prepare for segue to the Grocery List VC
    }

}

- (IBAction)onViewRecipeButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"RecipeToStepsSegue" sender:self];
}

#pragma mark - grocery list cache management

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

-(void)load {
    NSURL *pList = [[self documentsDirectory] URLByAppendingPathComponent:@"GroceryList.plist"];
    self.groceryListItems = [NSMutableArray arrayWithContentsOfURL:pList];
}

#pragma mark - prepareForSegue Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual:@"RecipeToStepsSegue"]){
        UINavigationController *recipeStepsNavigationController = segue.destinationViewController;
        RecipeCookingViewController *rcvc = [recipeStepsNavigationController.childViewControllers objectAtIndex:0];
    }
}

@end
