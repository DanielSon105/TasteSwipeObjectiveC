//
//  RecipeStep.h
//  TasteSwipeObjectiveC
//
//  Created by Michelle Burke on 11/16/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeStep : NSObject

@property NSString *order;
@property NSString *stepDescription;

-(instancetype)initWithContentsOfDictionary:(NSDictionary *)recipeDictionary;

@end
