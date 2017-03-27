//
//  NSObject+TMBorderline.h
//  
//
//  Created by tangshimi on 6/17/16.
//  Copyright © 2016 medtree. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, TMBorderlineDirection) {
    TMBorderlineDirectionNone = 0,
    TMBorderlineDirectionTop = 1 << 0,
    TMBorderlineDirectionBottom = 1 << 1,
    TMBorderlineDirectionLeft = 1 << 2,
    TMBorderlineDirectionRight = 1 << 3,
};

@interface UIView (TMBorderline)

- (void)tm_addBorderLine:(TMBorderlineDirection)dirction;

- (void)tm_addBorderLine:(TMBorderlineDirection)dirction color:(UIColor *)color;

@end
