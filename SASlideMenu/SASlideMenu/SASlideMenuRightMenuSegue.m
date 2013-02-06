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
    
    SASlideMenuRootViewController* source = self.sourceViewController;
    SASlideMenuRightMenuViewController* destination = self.destinationViewController;

    source.rightMenu = destination;
    destination.rootController = source;
}

@end
