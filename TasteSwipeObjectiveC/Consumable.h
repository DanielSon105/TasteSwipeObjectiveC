//
//  Consumable.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/13/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Consumable : NSObject
@property NSString * consumableDescription;
@property NSString * consumable_id;
@property NSString * image_url;
@property NSArray * consumableIngredients;
@property NSString * consumableName;
@property NSString * recipeID;

-(instancetype)initConsumableWithJSON:(NSDictionary *)json;

@end
