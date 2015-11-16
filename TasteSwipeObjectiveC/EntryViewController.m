//
//  EntryViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Michelle Burke on 11/16/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "EntryViewController.h"
#import "Recipe.h"
#import "RecipeStep.h"

@interface EntryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *order;
@property (weak, nonatomic) IBOutlet UILabel *stepDescription;

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadEntry];
}

-(void)loadEntry{
//    ((UILabel *) [self.view viewWithTag:10]).text = self.step.order;
//    ((UILabel *) [self.view viewWithTag:20]).text = self.step.stepDescription;
    self.order.text = self.step.order;
    self.stepDescription.text = self.step.stepDescription;
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
