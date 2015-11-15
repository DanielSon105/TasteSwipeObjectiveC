//
//  GroceryListItem.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/13/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "GroceryListItem.h"

@implementation GroceryListItem

-(instancetype)initWithJSON:(NSDictionary *)json{
    self = [super init];

    if (self) {
        self.ingredient = json[@"ingredient"];
        self.amount = json[@"description"];
        self.unitOfMeasurement = json[@"avatar_url"];
    }

    return self;
}

@end
