//
//  NutritionalInformationViewController.m
//  ToTryList-MealDetail-RecipeView
//
//  Created by Michelle Burke on 11/10/15.
//  Copyright © 2015 Burke-Barrido. All rights reserved.
//

#import "NutritionalInformationViewController.h"
#import "User.h"
#import "Consumable.h"

@interface NutritionalInformationViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *caloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *carbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *proteinLabel;
@property (weak, nonatomic) IBOutlet UILabel *fatLabel;


@end

@implementation NutritionalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
