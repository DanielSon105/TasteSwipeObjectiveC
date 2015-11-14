//
//  SwipedCardView.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/10/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import "Meal.h"

@protocol SwipedCardViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@end

@interface SwipedCardView : UIView

@property (weak) id <SwipedCardViewDelegate> delegate;

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic)CGPoint originalPoint;
@property (nonatomic,strong)OverlayView* overlayView;
@property (nonatomic,strong)UILabel* information; //%%% a placeholder for any card-specific information

@property(nonatomic,strong)Meal *meal;
@property(nonatomic,strong)UIImageView *mealImage;

-(void)leftClickAction;
-(void)rightClickAction;

@end

