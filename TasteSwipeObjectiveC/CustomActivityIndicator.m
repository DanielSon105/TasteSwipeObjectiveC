//
//  CustomActivityIndicator.m
//  TasteSwipeObjectiveC
//
//  Created by Daniel Barrido on 11/18/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "CustomActivityIndicator.h"

@implementation CustomActivityIndicator

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)rotateLayerInfinite:(CALayer *)layer
{
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    rotation.duration = 0.7f; // Speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [layer removeAllAnimations];
    [layer addAnimation:rotation forKey:@"Spin"];
}

@end
