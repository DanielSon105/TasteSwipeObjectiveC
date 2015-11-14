//
//  ToTryListTableViewCell.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/12/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "ToTryListTableViewCell.h"

@implementation ToTryListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)mealSelected:(ToTryListTableViewCell *)sender {
    NSLog(@"Food Button Selected");
//    [self.delegate toTryListTableViewCell:self didTapButton:sender]; //called the protocol method on the delegate property
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
