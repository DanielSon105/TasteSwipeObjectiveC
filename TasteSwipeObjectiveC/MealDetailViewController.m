//
//  MealDetailViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/11/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "MealDetailViewController.h"

@interface MealDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *mealImage;
@property (weak, nonatomic) IBOutlet UITableView *consumbleTableView;
@property NSMutableArray *consumablesArray;

@end

@implementation MealDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.consumablesArray = [NSMutableArray new]; // Pass in Consumables from previous VC?  OR load consumables based on passed in meal?... leaning towards the latter
    NSLog(@"%@", self.meal);
    // Do any additional setup after loading the view.
}

#pragma mark - Consumables Tableview Cell Datasource and Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.consumablesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsumableCell"];
//    cell.consumable = [self.toTryListMeals objectAtIndex:indexPath.row];
//    cell.textLabel.text = cell.toTryListMeal.mealName;
//    cell.imageView.image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:cell.toTryListMeal.mealImageURL]]];

    return cell;
}



-(NSURL *)documentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];

}


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
