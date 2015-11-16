//
//  Recipe.m
//  TasteSwipeObjectiveC
//
//  Created by Michelle Burke on 11/16/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

-(instancetype)initRecipeWithContentsOfDictionary:(NSDictionary *)recipeDictionary{
    self = [super init];
    if (self) {
        self.recipeID = recipeDictionary[@"id"];
        self.recipeSteps = recipeDictionary[@"recipe_steps"];
    }
    return self;
}

@end