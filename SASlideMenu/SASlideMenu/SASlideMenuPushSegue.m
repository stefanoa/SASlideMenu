//
//  SASlideMenuPushSegue.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 2/5/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuPushSegue.h"
#import "SASlideMenuRootViewController.h"
#import "SASlideMenuRightMenuViewController.h"
#import "SASlideMenuNavigationController.h"

@implementation SASlideMenuPushSegue
-(void) perform{
    
    SASlideMenuRightMenuViewController* source = self.sourceViewController;
    SASlideMenuRootViewController* root = source.rootController;
    SASlideMenuNavigationController* destination = self.destinationViewController;
    
    [root pushRightNavigationController:destination];
}

@end
