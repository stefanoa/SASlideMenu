//
//  SASlideMenuStaticStoryboardSegue.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/24/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SASlideMenuStaticStoryboardSegue.h"
#import "SASlideMenuStaticViewController.h"

@implementation SASlideMenuStaticStoryboardSegue

-(void) perform{
    SASlideMenuStaticViewController* source = self.sourceViewController;
    
    UINavigationController* destination = self.destinationViewController;
    
    UIButton* menuButton = [[UIButton alloc] init];
    [source.slideMenuDataSource configureMenuButton:menuButton];
    [menuButton addTarget:source action:@selector(doSlideToSide) forControlEvents:UIControlEventTouchUpInside];
    
    UINavigationItem* navigationItem = destination.navigationBar.topItem;
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];

    if ([source.slideMenuDataSource respondsToSelector:@selector(configureSlideLayer:)]) {
        [source.slideMenuDataSource configureSlideLayer:[destination.view layer]];
    }else{
        CALayer* layer = destination.view.layer;
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOpacity = 0.3;
        layer.shadowOffset = CGSizeMake(-15, 0);
        layer.shadowRadius = 10;
        layer.masksToBounds = NO;
        layer.shadowPath =[UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
    }
    
    [source switchToContentViewController:destination];
    
}

@end
