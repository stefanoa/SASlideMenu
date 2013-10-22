//
//  SASlideMenuLeftMenuSegue.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 1/17/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuLeftMenuSegue.h"
#import "SASlideMenuRootViewController.h"
#import "SASlideMenuViewController.h"

@implementation SASlideMenuLeftMenuSegue

-(void) perform{
    SASlideMenuRootViewController* rootViewController = self.sourceViewController;
    SASlideMenuViewController* leftMenu = self.destinationViewController;
    CGRect bounds = rootViewController.menuView.bounds;
    leftMenu.view.frame = CGRectMake(0,0,bounds.size.width,bounds.size.height);

    [leftMenu willMoveToParentViewController:rootViewController];
    [rootViewController addChildViewController:leftMenu];
    [rootViewController.menuView addSubview:leftMenu.view];
    rootViewController.leftMenu = leftMenu;
    
    leftMenu.rootController = rootViewController;
   
    [leftMenu didMoveToParentViewController:rootViewController];
    if ([rootViewController.leftMenu.slideMenuDataSource respondsToSelector:@selector(selectedIndexPath)]) {
        NSIndexPath* selectedIndexPath = [rootViewController.leftMenu.slideMenuDataSource selectedIndexPath];
        if (selectedIndexPath) {
            [leftMenu selectContentAtIndexPath:selectedIndexPath scrollPosition:UITableViewScrollPositionTop];
        }
    }   
}

@end
