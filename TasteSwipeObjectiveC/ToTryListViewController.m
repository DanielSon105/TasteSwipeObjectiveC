//
//  ToTryListViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/10/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "ToTryListViewController.h"
#import "MealDetailViewController.h"

@interface ToTryListViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *toTryListMeals;
@property NSDictionary *getMealDictionaryJSON;
@property NSMutableDictionary *arrayOfToTryMealDictionaries;
@property User *user;
@property NSString *temptoken;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property Meal *selectedMeal;

@end

@implementation ToTryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.temptoken = @"jBDN0mkWbvHLUKqqRA6v";
//    self.toTryListMeals = [NSMutableArray new];

    if (self.toTryListMeals == nil){
        self.toTryListMeals = [NSMutableArray new];
        self.getMealDictionaryJSON = [NSDictionary new];
        self.temptoken = @"jBDN0mkWbvHLUKqqRA6v";
        [self getToTryListMeals:self.temptoken];
    }
}





-(void)getToTryListMeals:(NSString *)token
{
    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];

    NSURL *url = [NSURL URLWithString:@"http://tasteswipe-int.herokuapp.com/try_meals"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", token] forHTTPHeaderField:@"Authorization"];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error != nil) {
            NSLog(@"---> ERROR :: %@", error);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.user = [User new];
            self.user.token = token; //THIS IS JUST HERE UNTIL I FIND A BETTER WAY TO GO ABOUT MANAGING THE TOKEN STUFF.

            self.getMealDictionaryJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            self.arrayOfToTryMealDictionaries = [self.getMealDictionaryJSON objectForKey:@"try_meals"];
            NSLog(@"Array of To Try Meal Dictionaries --> %@",self.arrayOfToTryMealDictionaries);
            self.toTryListMeals = [NSMutableArray new];
            for (NSDictionary *dict in self.arrayOfToTryMealDictionaries) {
                Meal *meal = [[Meal alloc] initMealWithContentsOfDictionary:dict];
                [self.toTryListMeals addObject:meal];
                NSLog(@"The meal added to To Try List Meals is --> %@", meal);
            }
            [self.tableView reloadData];

        });
    }];
    [task resume];
}

-(void)markMealAsTried{

}




#pragma mark - Tableview Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.toTryListMeals.count;
}

-(ToTryListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ToTryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToTryListCell" forIndexPath:indexPath];
    cell.toTryListMeal = [self.toTryListMeals objectAtIndex:indexPath.row];
    cell.textLabel.text = cell.toTryListMeal.mealName;
    cell.imageView.image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:cell.toTryListMeal.mealImageURL]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    [self performSegueWithIdentifier: @"TryToMealDetailSegue" sender:self];
    //go to meal detail view
}

#pragma mark - Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual: @"TryToMealDetailSegue"]) {
        MealDetailViewController *mdvc = segue.destinationViewController;

        mdvc.meal = self.selectedMeal;
    }
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
