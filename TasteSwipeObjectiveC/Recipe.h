//
//  Recipe.h
//  TasteSwipeObjectiveC
//
//  Created by Michelle Burke on 11/16/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property NSString *recipeID;
@property NSArray *recipeSteps;

-(instancetype)initRecipeWithContentsOfDictionary:(NSDictionary *)recipeDictionary;

@end
