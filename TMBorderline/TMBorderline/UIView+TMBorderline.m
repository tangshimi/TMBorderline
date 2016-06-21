//
//  NSObject+TMBorderline.m
//  
//
//  Created by tangshimi on 6/17/16.
//  Copyright © 2016 medtree. All rights reserved.
//

#import "UIView+TMBorderline.h"
#import "Aspects.h"

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@implementation UIView (TMBorderline)

-(void)tm_addBoardLine:(TMBorderlineDirection)dirction color:(UIColor *)color
{
    if (dirction & TMBorderlineDirectionTop) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        [self aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspcetInfo) {
            layer.frame = CGRectMake(0, -SINGLE_LINE_ADJUST_OFFSET, CGRectGetWidth(self.frame), SINGLE_LINE_WIDTH);
        } error:NULL];
    }
    
    if (dirction & TMBorderlineDirectionBottom) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        [self aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspcetInfo) {
            layer.frame = CGRectMake(0, CGRectGetHeight(self.frame) - SINGLE_LINE_ADJUST_OFFSET, CGRectGetWidth(self.frame), SINGLE_LINE_WIDTH);
        } error:NULL];
    }
    
    if (dirction & TMBorderlineDirectionLeft) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        [self aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspcetInfo) {
            layer.frame = CGRectMake(-SINGLE_LINE_ADJUST_OFFSET, 0, SINGLE_LINE_WIDTH, CGRectGetHeight(self.frame));
        } error:NULL];
    }
    
    if (dirction & TMBorderlineDirectionRight) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        [self aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspcetInfo) {
            layer.frame = CGRectMake( CGRectGetWidth(self.frame) - SINGLE_LINE_ADJUST_OFFSET, 0, SINGLE_LINE_WIDTH, CGRectGetHeight(self.frame));
        } error:NULL];
    }
}

- (void)tm_addBoardLine:(TMBorderlineDirection)dirction
{
    [self tm_addBoardLine:dirction color:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]];
}

@end
