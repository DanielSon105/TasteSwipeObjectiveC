//
//  GroceryListItem.h
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/13/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroceryListItem : NSObject
@property NSInteger *groceryListItemID;
@property NSString *ingredient;
@property NSString *amount;
@property NSString *unitOfMeasurement;

-(instancetype)initWithJSON:(NSDictionary *)dictionary;

@end
