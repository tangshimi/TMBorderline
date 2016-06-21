//
//  ViewController.m
//  TMBorderline
//
//  Created by tangshimi on 6/21/16.
//  Copyright © 2016 medtree. All rights reserved.
//

#import "ViewController.h"
#import "UIView+TMBorderline.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(50, 210, 300, 100);
    
    [self.view addSubview:lineView];
    
    //    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    //
    //    NSDictionary *view = @{ @"lineView" :  lineView  };
    //
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[lineView]-100-|" options:0 metrics:nil views:view]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[lineView(200)]" options:0 metrics:nil views:view]];
    
    [lineView tm_addBoardLine:TMBorderlineDirectionTop |  TMBorderlineDirectionBottom| TMBorderlineDirectionLeft|TMBorderlineDirectionRight color:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
