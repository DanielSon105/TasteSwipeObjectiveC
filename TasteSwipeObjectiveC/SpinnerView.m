//
//  SpinnerView.m
//  TasteSwipeObjectiveC
//
//  Created by Michelle Burke on 11/18/15.
//  Copyright © 2015 Daniel Barrido. All rights reserved.
//

#import "SpinnerView.h"

@implementation SpinnerView



-(void)layoutSubviews
{
    [super layoutSubviews];

    // some other code

    [Utils rotateLayerInfinite:self.activityIndicatorImage.layer];
}

+(void)rotateLayerInfinite:(CALayer *)layer
{
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    rotation.duration = 0.7f; // speed
    rotation.repeatCount = HUGE_VALF; // repeat forever. can be a finite number.
    [layer removeAllAnimations];
    [layer addAnimation:rotation forKey:@"Spin"];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    // set up animation
    [self.view addSubview:self.activityIndicatorImage];
    // start animation
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    // stop animation
    [self.activityIndicatorImage removeFromSuperview];
}


// self.activityIndicatorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"restaurant"]];

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
