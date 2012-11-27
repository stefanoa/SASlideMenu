//
//  SASlideMenuRightMenuSegue.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/25/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuRightMenuSegue.h"
#import "SASlideMenuDynamicViewController.h"
@implementation SASlideMenuRightMenuSegue
-(void) perform{
    
    SASlideMenuDynamicViewController* source = self.sourceViewController;
    UINavigationController* destination = self.destinationViewController;

    source.rightMenu = destination;
}

@end
