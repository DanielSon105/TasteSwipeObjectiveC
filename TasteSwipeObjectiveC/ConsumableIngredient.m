//
//  ConsumableIngredient.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/14/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "ConsumableIngredient.h"

@implementation ConsumableIngredient

-(instancetype)initConsumableIngredientWithJSON:(NSDictionary *)json{
    self = [super init];

    if (self) {
        self.amount = json[@"amount"];
        self.unitOfMeasurement = json[@"unit"];
        self.ingredientDictionary = json[@"ingredient"];
        self.ingredientID = json[@"ingredient"][@"id"];
        self.ingredientName = json[@"ingredient"][@"name"];
        self.ingredientDescription = json[@"description"];
        self.imageURL = json[@"ingredient"][@"image_url"];
    }

    return self;
}

@end