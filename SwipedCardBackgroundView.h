//
//  SwipedCardBackgroundView.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/10/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipedCardView.h"
#import "User.h"
#import "Meal.h"

@interface SwipedCardBackgroundView : UIView <SwipedCardViewDelegate>

//methods called in SwipedCardView
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;
-(void)getMealInfo:(NSString *)token;

@property (retain,nonatomic)NSArray* exampleCardLabels; //%%% the labels the cards
@property (retain,nonatomic)NSMutableArray* randomJSONMeals; //%%% replace exampleCardLabels with these
@property (retain,nonatomic)NSMutableArray* allCards; //%%% the labels the cards

@property User *user;

@end
