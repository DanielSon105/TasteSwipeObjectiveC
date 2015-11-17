//
//  NutritionalInformationViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/16/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "NutritionalInformationViewController.h"

@interface NutritionalInformationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *calorieInformation;
@property (weak, nonatomic) IBOutlet UILabel *carbGrams;
@property (weak, nonatomic) IBOutlet UILabel *proteinGrams;
@property (weak, nonatomic) IBOutlet UILabel *fatGrams;

@end

@implementation NutritionalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
