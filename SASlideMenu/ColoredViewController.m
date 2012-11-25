//
//  ColoredViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/21/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "ColoredViewController.h"

@interface ColoredViewController ()

@end

@implementation ColoredViewController
-(void) tap{
    NSLog(@"tap");
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"[%@ initWithCoder:]",self);
        
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tapGesture];
    NSLog(@"[%@ viewDidLoad]",self);
}

-(void) viewWillAppear:(BOOL)animated{
    NSLog(@"[%@ viewWillAppear:]",self);
    [super viewWillAppear:animated];
}

-(void) setBackgroundHue:(CGFloat) hue brightness:(CGFloat) brightness{
    self.view.backgroundColor = [UIColor colorWithHue:hue saturation:1.0 brightness:brightness alpha:1.0];
}

@end
