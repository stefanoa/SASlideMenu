//
//  SASlideMenuRightMenuSegue.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/25/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuRightMenuSegue.h"
#import "SASlideMenuRootViewController.h"
#import "SASlideMenuRightMenuViewController.h"
@implementation SASlideMenuRightMenuSegue
-(void) perform{
    UINavigationController* source = self.sourceViewController;
    
    SASlideMenuRightMenuViewController* rightMenuViewController = self.destinationViewController;
    SASlideMenuRootViewController* rootViewController = (SASlideMenuRootViewController*)source.parentViewController;
    
    rootViewController.rightMenu = rightMenuViewController;
    rightMenuViewController.rootController = rootViewController;
}

@end
