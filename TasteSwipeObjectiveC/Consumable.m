//
//  Consumable.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/13/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "Consumable.h"

@implementation Consumable

-(instancetype)initConsumableWithJSON:(NSDictionary *)json{
    self = [super init];

    if (self) {
        self.consumableDescription = json[@"description"];
        self.consumable_id = json[@"id"];
        self.image_url = json[@"image_url"];
        self.consumableIngredients = json[@"ingredients"];
        self.consumableName = json[@"name"];

    }

    return self;
}

@end
