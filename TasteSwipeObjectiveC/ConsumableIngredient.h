//
//  ConsumableIngredient.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/14/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsumableIngredient : NSObject
@property NSString *amount;
@property NSString *unitOfMeasurement;

@property NSDictionary *ingredientDictionary;

@property NSString *ingredientID;
@property NSString *ingredientName;
@property NSString *ingredientDescription;
@property NSString *imageURL;

@property BOOL addedToCart;

-(instancetype)initConsumableIngredientWithJSON:(NSDictionary *)json;



//description STRING    ****** use this and change to unit of measurement after charlie updates
//id NUMBER?STRING?   ****** use this and change to amount afterwards
//“image_url” STRING
//name STRING    *****

@end
