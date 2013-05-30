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
    CGRect bounds = rootViewController.view.bounds;
    leftMenu.view.frame = CGRectMake(0,0,bounds.size.width,bounds.size.height);

    [leftMenu willMoveToParentViewController:rootViewController];
    [rootViewController addChildViewController:leftMenu];
    [rootViewController.view addSubview:leftMenu.view];
    rootViewController.leftMenu = leftMenu;
    
    leftMenu.rootController = rootViewController;
   
    [leftMenu didMoveToParentViewController:rootViewController];
    if ([rootViewController.leftMenu.slideMenuDataSource respondsToSelector:@selector(selectedIndexPath)]) {
        NSIndexPath* selectedIndexPath = [rootViewController.leftMenu.slideMenuDataSource selectedIndexPath];
        [leftMenu.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        NSString* initialSegueId = [rootViewController.leftMenu.slideMenuDataSource segueIdForIndexPath:selectedIndexPath];
        [leftMenu performSegueWithIdentifier:initialSegueId sender:leftMenu];
    }
   
}

@end
