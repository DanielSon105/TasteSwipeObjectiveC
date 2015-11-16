//
//  SwipedCardBackgroundView.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/10/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "SwipedCardBackgroundView.h"
#import "SwipedCardView.h"
#import "NetworkClient.h"

@implementation SwipedCardBackgroundView{
    NSInteger cardsLoadedIndex; //%%% the index of the card you have loaded into the loadedCards array last
    NSMutableArray *loadedCards; //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)

    NSDictionary *getMealDictionaryJSON;
    NSMutableArray *arrayOfMealDictionaries;

    UIButton* menuButton;
    UIButton* messageButton;
    UIButton* checkButton;
    UIButton* xButton;
}

static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
static const float CARD_HEIGHT = 386; //%%% height of the draggable card
static const float CARD_WIDTH = 290; //%%% width of the draggable card

@synthesize exampleCardLabels; //%%% all the labels I'm using as example data at the moment
@synthesize allCards;//%%% all the cards

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super layoutSubviews];
        [self setupView];
//        exampleCardLabels = [[NSArray alloc]initWithObjects:@"first",@"second",@"third",@"fourth",@"last", nil]; //%%% placeholder for card-specific information
////        loadedCards = [[NSMutableArray alloc] init];
////        allCards = [[NSMutableArray alloc] init];
////        cardsLoadedIndex = 0;
////        [self loadCards];
    }
    return self;
}

-(void)getMealInfo:(NSString *)token
{
    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];

    NSURL *url = [NSURL URLWithString:@"http://tasteswipe-int.herokuapp.com/random_meals"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"Token token=\"%@\"; charset=utf-8", token] forHTTPHeaderField:@"Authorization"];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error != nil) {
            NSLog(@"---> ERROR :: %@", error);
        }
        dispatch_async(dispatch_get_main_queue(), ^{

//            self.user.token = token; //THIS IS JUST HERE UNTIL I FIND A BETTER WAY TO GO ABOUT MANAGING THE TOKEN STUFF.

            getMealDictionaryJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            arrayOfMealDictionaries = [getMealDictionaryJSON objectForKey:@"meals"];
//            NSLog(@"%@",arrayOfMealDictionaries);
            self.randomJSONMeals = [NSMutableArray new];
            for (NSDictionary *dict in arrayOfMealDictionaries) {
                Meal *meal = [[Meal alloc] initMealWithContentsOfDictionary:dict];
                [self.randomJSONMeals addObject:meal];
            }
            loadedCards = [[NSMutableArray alloc] init];
            allCards = [[NSMutableArray alloc] init];
            cardsLoadedIndex = 0;
            [self loadCards];
        });
    }];
    [task resume];
}






//%%% sets up the extra buttons on the screen
-(void)setupView
{
    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1]; //the gray background colors
    menuButton = [[UIButton alloc]initWithFrame:CGRectMake(17, 34, 22, 15)];
    [menuButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    messageButton = [[UIButton alloc]initWithFrame:CGRectMake(284, 34, 18, 18)];
    [messageButton setImage:[UIImage imageNamed:@"messageButton"] forState:UIControlStateNormal];
    xButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 485, 59, 59)];
    [xButton setImage:[UIImage imageNamed:@"xButton"] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 485, 59, 59)];
    [checkButton setImage:[UIImage imageNamed:@"checkButton"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:menuButton];
    [self addSubview:messageButton];
    [self addSubview:xButton];
    [self addSubview:checkButton];
}

#pragma mark - Card Customization

-(SwipedCardView *)createSwipedCardViewWithDataAtIndex:(NSInteger)index
{
    NSLog(@"Create Swiped Card Background View With Data At Index Called");
    SwipedCardView *swipedCardView = [[SwipedCardView alloc]initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)];
    swipedCardView.meal = [self.randomJSONMeals objectAtIndex:index];
    swipedCardView.information.text = swipedCardView.meal.mealName;
    swipedCardView.meal.mealImageURL = swipedCardView.meal.mealImageURL;
    swipedCardView.mealImage.image = [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:swipedCardView.meal.mealImageURL]]];



    NSLog(@"%@,%f", swipedCardView.meal.mealName, swipedCardView.mealImage.frame.origin.x);
//    swipedCardView.mealImage.backgroundColor = [UIColor blueColor];


    swipedCardView.delegate = self;
    return swipedCardView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
    NSLog(@"Load Cards Called");
    if([self.randomJSONMeals count] > 0) {
        NSInteger numLoadedCardsCap =(([self.randomJSONMeals count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[self.randomJSONMeals count]);

        for (int i = 0; i<[self.randomJSONMeals count]; i++) {
            SwipedCardView* newCard = [self createSwipedCardViewWithDataAtIndex:i];
            NSLog(@"newCard instantiated.");
            [allCards addObject:newCard];

            if (i<numLoadedCardsCap) {
                NSLog(@"i is less than numLoadedCardsCap and Cap is %lu", numLoadedCardsCap);
                //adds a small number of cards to be loaded
                [loadedCards addObject:newCard];
            }
        }

        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
                NSLog(@"insert Subview called");
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
                NSLog(@"add Subview called");
            }
            NSLog(@"cardsLoadedIndex called");
            cardsLoadedIndex++; //increment after loading a card
        }
    }
}

//action(s) called when the card goes to the left
-(void)cardSwipedLeft:(UIView *)card;
{
    NSLog(@"Card Swiped Left Called");
    //do whatever you want with the card that was swiped
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"];
    SwipedCardView *c = (SwipedCardView *)card;
    [c.meal postMealToDisinterestedList:accessToken];

    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"

    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
}

//action called when the card goes to the right.
-(void)cardSwipedRight:(UIView *)card
{
    NSUserDefaults *tokenDef = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [tokenDef stringForKey:@"accessToken"];
    NSLog(@"Card Swiped Right Called");
    SwipedCardView *c = (SwipedCardView *)card;
    NSLog(@"%@", c);
    [c.meal postMealToToTryList:accessToken];
    

    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"

    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
        NSLog(@"Loaded Cards - %lu allCards - %lu", [loadedCards count], [allCards count]);
    }

}

//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    NSLog(@"Swipe Right Called");
    SwipedCardView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    NSLog(@"Swipe Left Called");
    SwipedCardView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
}



@end
