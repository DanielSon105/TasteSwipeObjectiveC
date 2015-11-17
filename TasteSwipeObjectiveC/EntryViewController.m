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
@property (weak, nonatomic) IBOutlet UITextView *stepDescription;

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadEntry];
}

-(void)loadEntry{
    NSString *strTextView = [NSString stringWithFormat:@"Step %@: %@", self.step.order, self.step.stepDescription];

    NSRange rangeBold = [strTextView rangeOfString:[NSString stringWithFormat:@"Step %@:", self.step.order]];

    UIFont *fontText = [UIFont boldSystemFontOfSize:14];
    NSDictionary *dictBoldText = [NSDictionary dictionaryWithObjectsAndKeys:fontText, NSFontAttributeName, nil];

    NSMutableAttributedString *mutAttrTextViewString = [[NSMutableAttributedString alloc] initWithString:strTextView];
    [mutAttrTextViewString setAttributes:dictBoldText range:rangeBold];

    [self.stepDescription setAttributedText:mutAttrTextViewString];
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
