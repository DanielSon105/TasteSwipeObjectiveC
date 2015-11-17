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

@interface RecipeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *ingredientsTableView;
@property NSArray *consumableIngredients;
@property NSMutableArray *ingredients;
@property ConsumableIngredient *selectedIngredient;

@property (weak, nonatomic) IBOutlet UIButton *showRecipeButton;

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showRecipeButton.hidden = YES;

    //Load the grocery list Plist on this view Controller

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

    //Click Grocery Cart to add it to your grocery List ... Icon Changes?

    //Populate Alert View that asks for confirmation
    //IF you confirm then add Grocery List Item to Array of Grocery List Items and update PList

    //NOTE: we also need to send either the grocery list array OR the PList File through the prepare for segue to the Grocery List VC
}

- (IBAction)onViewRecipeButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"RecipeToStepsSegue" sender:self];
}

#pragma mark - prepareForSegue Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual:@"RecipeToStepsSegue"]){
        UINavigationController *recipeStepsNavigationController = segue.destinationViewController;
        RecipeCookingViewController *rcvc = [recipeStepsNavigationController.childViewControllers objectAtIndex:0];
    }
}

@end
