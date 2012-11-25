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
    [source switchToContentViewController:destination];
    
    [source addContentViewController:destination withIndexPath:source.selectedIndexPath];
}
@end
