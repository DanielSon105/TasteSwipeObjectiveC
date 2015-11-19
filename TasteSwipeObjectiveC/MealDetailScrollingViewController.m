//
//  MealDetailScrollingViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/18/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "MealDetailScrollingViewController.h"
#import "ConsumableTableViewCell.h"
#import "RecipeViewController.h"
#import "CommentTableViewCell.h"

@interface MealDetailScrollingViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mealImage;
@property (weak, nonatomic) IBOutlet UITableView *consumableTableView;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;
@property NSMutableArray *consumablesArray;
@property Consumable *selectedConsumable;

@property NSMutableArray *commentsArray;

@property NSString *fakecomment1;
@property NSString *fakecomment2;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation MealDetailScrollingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:0
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:60];
    [self.view addConstraint:leftConstraint];

    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:0
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:-60];
    [self.view addConstraint:rightConstraint];
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.meal.mealImageURL]];
    self.mealImage.image = [UIImage imageWithData:imageData];
    self.consumablesArray = [NSMutableArray new];
    for (NSDictionary *dict in self.meal.mealConsumablesArray) {
        Consumable *consumable = [[Consumable alloc] initConsumableWithJSON:dict];
        [self.consumablesArray addObject:consumable];
    }

    self.fakecomment1 = @"Danny's mom makes some delicious meals!";
    self.fakecomment2 = @"I wish my food looked as delicious as the picture!";
    self.commentsArray = [[NSMutableArray alloc] initWithObjects:self.fakecomment1, self.fakecomment2, nil];

    // Pass in Consumables from previous VC?  OR load consumables based on passed in meal?... leaning towards the latter
    NSLog(@"%@", self.meal);
    NSLog(@"%@", self.meal.mealName);
    // Do any additional setup after loading the view.
}

#pragma mark - Consumables Tableview Cell Datasource and Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.commentsTableView]) {
        return self.commentsArray.count;
    } else {
        return self.consumablesArray.count;

    }

}

-(id)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView.restorationIdentifier isEqualToString:@"CommentsTableView"]){
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        return cell;
    } else {
    ConsumableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsumableCell"];
    cell.consumable = [self.consumablesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cell.consumable.consumableName;
    NSLog(@"Cell Consumable Info --> %@", cell.consumable);
    //    cell.imageView.image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:cell.toTryListMeal.mealImageURL]]];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView.restorationIdentifier isEqualToString:@"CommentsTableView"]){

    } else {

    self.selectedConsumable = [self.consumablesArray objectAtIndex:indexPath.row]; // make sure this is the correct array
    NSLog(@"self.selected Consumable didSelectRow --> %@", self.selectedConsumable);
    [self performSegueWithIdentifier: @"ConsumablesToRecipeSegue" sender:self];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    //self.selectedComment = [self.commentsArray objectAtIndex:indexPath.row];
    //[self performSegueWithIdentifier: @Commen

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
