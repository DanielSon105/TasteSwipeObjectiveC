//
//  RecipeStep.m
//  TasteSwipeObjectiveC
//
//  Created by Michelle Burke on 11/16/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "RecipeStep.h"

@implementation RecipeStep

-(instancetype)initWithContentsOfDictionary:(NSDictionary *)recipeDictionary{
    self = [super init];
    if (self) {
        self.order = recipeDictionary[@"order"];
        self.stepDescription = recipeDictionary[@"description"];
    }
    return self;
}

@end
