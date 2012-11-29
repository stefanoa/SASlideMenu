//
//  SASlideMenuStoryboardSegue.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/30/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuDynamicStoryboardSegue.h"
#import "SASlideMenuDynamicViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation SASlideMenuDynamicStoryboardSegue


-(void) perform{
    SASlideMenuDynamicViewController* source = self.sourceViewController;
    UINavigationController* destination = self.destinationViewController;
    
    UIButton* menuButton = [[UIButton alloc] init];
    [source.slideMenuDataSource configureMenuButton:menuButton];
    [menuButton addTarget:source action:@selector(doSlideToSide) forControlEvents:UIControlEventTouchUpInside];
    
    UINavigationItem* navigationItem = destination.navigationBar.topItem;
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];

    Boolean hasRightMenu = NO;
    if ([source.slideMenuDataSource respondsToSelector:@selector(hasRightMenuForIndexPath:)]) {
        hasRightMenu = [source.slideMenuDataSource hasRightMenuForIndexPath:source.selectedIndexPath];
    }
    if (hasRightMenu) {
        if ([source.slideMenuDataSource respondsToSelector:@selector(configureRightMenuButton:)]) {
            UIButton* rightMenuButton = [[UIButton alloc] init];
            [source.slideMenuDataSource configureRightMenuButton:rightMenuButton];
            [rightMenuButton addTarget:source action:@selector(rightMenuAction) forControlEvents:UIControlEventTouchUpInside];
            
            UINavigationItem* navigationItem = destination.navigationBar.topItem;
            navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightMenuButton];
        }
        
    }
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
    [source addContentViewController:destination withIndexPath:source.selectedIndexPath];
}
@end
