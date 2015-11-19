//
//  SwipeViewController.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/10/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "SwipeViewController.h"
#import "SwipedCardBackgroundView.h"
#import "NetworkClient.h"

@interface SwipeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation SwipeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSArray *arrayBlah = [NSArray new];
//    NetworkClient *nc = [NetworkClient new];
//    [nc saveGroceryListToCache:arrayBlah];



    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"];

    NSLog(@"NSUserDefaults value for accessToken key --> %@", accessToken);
    SwipedCardBackgroundView *swipedCardBackgroundView = [[SwipedCardBackgroundView alloc]initWithFrame:self.view.frame];
    [swipedCardBackgroundView getMealInfo:accessToken];
    [self.view addSubview:swipedCardBackgroundView];
//    [self.view sendSubviewToBack:self.backgroundImageView];
    [self.view insertSubview:self.backgroundImageView atIndex:0];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"foodbackgroundphoto4"]];
//    self.view.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view sendSubviewToBack:self.backgroundImageView];
    NSLog(@"SwipedCardBackgroundView alloc init complete");
}

@end
