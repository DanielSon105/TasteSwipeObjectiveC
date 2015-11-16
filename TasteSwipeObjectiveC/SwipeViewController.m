//
//  SwipeViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/10/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "SwipeViewController.h"
#import "SwipedCardBackgroundView.h"

@interface SwipeViewController ()

@end

@implementation SwipeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"];

    NSLog(@"NSUserDefaults value for accessToken key --> %@", accessToken);
    SwipedCardBackgroundView *swipedCardBackgroundView = [[SwipedCardBackgroundView alloc]initWithFrame:self.view.frame];
    [swipedCardBackgroundView getMealInfo:accessToken];
    [self.view addSubview:swipedCardBackgroundView];
    NSLog(@"SwipedCardBackgroundView alloc init complete");
}

@end
