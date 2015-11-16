//
//  SwipedCardView.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/10/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//
#define ACTION_MARGIN 120 //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 //%%% how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 //%%% upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 //%%% strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 //%%% Higher = stronger rotation angle

#import "SwipedCardView.h"

@implementation SwipedCardView {
    CGFloat xFromCenter;
    CGFloat yFromCenter;
}

//delegate is instance of ViewController
@synthesize delegate;

@synthesize panGestureRecognizer;
@synthesize information;
@synthesize overlayView;
@synthesize meal;
@synthesize mealImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        NSLog(@"Init With Frame in SwipedCardView.m Called");

#pragma mark - Card Specific Information

        self.meal = [Meal new];
        information = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height*.8, self.frame.size.width, 100)];
        information.text = @"no info given";
        [information setTextAlignment:NSTextAlignmentCenter];
        information.textColor = [UIColor blackColor];

        self.mealImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width *.05, 50, self.frame.size.width * .9, self.frame.size.width * .9)];
//        self.mealImage.backgroundColor = [UIColor blueColor];
//        NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.meal.mealImageURL]];
//        self.mealImage.image = [UIImage imageWithData: imageData];
        NSLog(@"MealImageURL --> %@", self.meal.mealImageURL);
//        self.mealImage.backgroundColor = [UIColor orangeColor];
//        UIImage *scaledMealImage = [UIImage initWithCGImage:mealImage.image scale:((mealImage.image.size.height/mealImage.frame.size.height),(mealImage.image.size.width/mealImage.frame.size.width)) orientation:UIImageOrientationUp;

        self.backgroundColor = [UIColor whiteColor];

        panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];

        [self addGestureRecognizer:panGestureRecognizer];
        [self addSubview:information];
        [self addSubview:mealImage];

        overlayView = [[OverlayView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-100, 0, 100, 100)];
        overlayView.alpha = 0;
        [self addSubview:overlayView];
    }
    return self;
}

-(void)setupView
{
    NSLog(@"Setup View Called");
    self.layer.cornerRadius = 4;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Card Drag Effect

-(void)beingDragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    //coordinate data from your swipe movement
    xFromCenter = [gestureRecognizer translationInView:self].x; //positive for right swipe, negative for left
    yFromCenter = [gestureRecognizer translationInView:self].y; //positive for up, negative for down

    //gesture state
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: //just started swiping
        {
            self.originalPoint = self.center;
            break;
        };

        case UIGestureRecognizerStateChanged: //in the middle of a swipe
        {
            CGFloat rotationStrength = MIN(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX); //dictates rotation
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength); //degree change in radians
            CGFloat scale = MAX(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX); //amount the height changes when you move the card up to a certain point
            self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter); //move the object's center
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel); //rotate by certain amount
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale); //scale by certain amount

            //apply transformations
            self.transform = scaleTransform;
            [self updateOverlay:xFromCenter];

            break;
        };

        case UIGestureRecognizerStateEnded: //let go of the card
        {
            [self afterSwipeAction];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

#pragma mark - Check and X Population When Swiping
//Applies a Check when swiping Right and an X when swiping left.  Consider changing these graphics
-(void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        overlayView.mode = GGOverlayViewModeRight;
    } else {
        overlayView.mode = GGOverlayViewModeLeft;
    }

    overlayView.alpha = MIN(fabs(distance)/100, 0.4);
}

#pragma mark - Letting Go of The Card

- (void)afterSwipeAction
{
    if (xFromCenter > ACTION_MARGIN) {
        [self rightAction];
    } else if (xFromCenter < -ACTION_MARGIN) {
        [self leftAction];
    } else { //%%% resets the card
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             overlayView.alpha = 0;
                         }];
    }
}

//%%% called when a swipe exceeds the ACTION_MARGIN to the right
-(void)rightAction
{

    CGPoint finishPoint = CGPointMake(500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];

    [delegate cardSwipedRight:self];

    NSLog(@"YES");
}

//%%% called when a swip exceeds the ACTION_MARGIN to the left
-(void)leftAction
{
    CGPoint finishPoint = CGPointMake(-500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];

    [delegate cardSwipedLeft:self];

    NSLog(@"NO");
}

-(void)rightClickAction
{
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];

    [delegate cardSwipedRight:self];

    NSLog(@"YES");
}

-(void)leftClickAction
{
    CGPoint finishPoint = CGPointMake(-600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];

    [delegate cardSwipedLeft:self];

    NSLog(@"NO");
}



@end

