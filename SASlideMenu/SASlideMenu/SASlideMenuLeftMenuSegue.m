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
    [UIView animateWithDuration:1.0 animations:^{
        leftMenu.view.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        [leftMenu didMoveToParentViewController:rootViewController];
        NSString* initiaSegueId = [rootViewController.leftMenu.slideMenuDataSource initialSegueId];
        [leftMenu performSegueWithIdentifier:initiaSegueId sender:leftMenu];
    }];
}

@end
