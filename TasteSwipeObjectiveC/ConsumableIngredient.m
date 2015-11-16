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
        self.ingredientDescription = json[@"description"];
        self.ingredientID = json[@"id"];
        self.imageURL = json[@"image_url"];
        self.ingredientName = json[@"name"];
    }

    return self;
}

@end
