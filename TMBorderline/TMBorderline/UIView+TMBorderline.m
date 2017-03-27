//
//  NSObject+TMBorderline.m
//  
//
//  Created by tangshimi on 6/17/16.
//  Copyright © 2016 medtree. All rights reserved.
//

#import "UIView+TMBorderline.h"
#import <objc/runtime.h>

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@interface UIView ()

@property (nonatomic, copy) NSArray *directions;
@property (nonatomic, copy) NSArray<CALayer *> *borderLines;

@end

@implementation UIView (TMBorderline)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(layoutSubviews);
        SEL swizzledSelector = @selector(gh_layoutSubviews);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark -
#pragma mark - setter and getter -

- (void)setDirections:(NSArray *)directions
{
    objc_setAssociatedObject(self, @selector(directions), directions, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSArray *)directions
{
    return objc_getAssociatedObject(self, @selector(directions));
}

- (void)setBorderLines:(NSArray<CALayer *> *)borderLines
{
    objc_setAssociatedObject(self, @selector(borderLines), borderLines, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSArray<CALayer *> *)borderLines
{
    return objc_getAssociatedObject(self, @selector(borderLines));
}

#pragma mark -
#pragma mark - public -

- (void)tm_addBorderLine:(TMBorderlineDirection)dirction
{
    [self tm_addBorderLine:dirction color:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]];
}

- (void)tm_addBorderLine:(TMBorderlineDirection)dirction color:(UIColor *)color
{
    NSMutableArray *directions = [NSMutableArray new];
    NSMutableArray *borderLines = [NSMutableArray new];
    
    if (dirction & TMBorderlineDirectionTop) {
        [directions addObject:@(TMBorderlineDirectionTop)];
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        [borderLines addObject:layer];
    }
    
    if (dirction & TMBorderlineDirectionBottom) {
        [directions addObject:@(TMBorderlineDirectionBottom)];
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        [borderLines addObject:layer];
    }
    
    if (dirction & TMBorderlineDirectionLeft) {
        [directions addObject:@(TMBorderlineDirectionLeft)];
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        [borderLines addObject:layer];
    }
    
    if (dirction & TMBorderlineDirectionRight) {
        [directions addObject:@(TMBorderlineDirectionRight)];
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        [borderLines addObject:layer];
    }
    
    self.directions = [directions copy];
    self.borderLines = [borderLines copy];
}

#pragma mark -
#pragma mark - hook -

- (void)gh_layoutSubviews
{
    [self gh_layoutSubviews];
    
    if (!(self.borderLines.count > 0 && self.directions.count > 0)) {
        return;
    }
    
    [self.directions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TMBorderlineDirection direction = [obj integerValue];
        CALayer *layer = self.borderLines[idx];
        
        switch (direction) {
            case TMBorderlineDirectionTop: {
                layer.frame = CGRectMake(0, -SINGLE_LINE_ADJUST_OFFSET, CGRectGetWidth(self.frame), SINGLE_LINE_WIDTH);
                break;
            }
            case TMBorderlineDirectionBottom:
                layer.frame = CGRectMake(0, CGRectGetHeight(self.frame) - SINGLE_LINE_ADJUST_OFFSET, CGRectGetWidth(self.frame), SINGLE_LINE_WIDTH);
                break;
            case TMBorderlineDirectionRight:
                layer.frame = CGRectMake(-SINGLE_LINE_ADJUST_OFFSET, 0, SINGLE_LINE_WIDTH, CGRectGetHeight(self.frame));
                break;
            case TMBorderlineDirectionLeft:
                layer.frame = CGRectMake( CGRectGetWidth(self.frame) - SINGLE_LINE_ADJUST_OFFSET, 0, SINGLE_LINE_WIDTH, CGRectGetHeight(self.frame));
                break;
            default:
                break;
        }
    }];
}

@end
