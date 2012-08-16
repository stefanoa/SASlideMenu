//
//  SASlideMenuStoryboardSegue.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/30/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuStoryboardSegue.h"
#import "SASlideMenuViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SASlideMenuButton.h"

@implementation SASlideMenuStoryboardSegue


-(void) perform{
    SASlideMenuViewController* source = self.sourceViewController;
    UINavigationController* destination = self.destinationViewController;
    SASlideMenuButton* menuButton = [[SASlideMenuButton alloc] initWithFrame:CGRectMake(0, 0, 40, 29)];
    menuButton.delegate = source;
    UINavigationItem* navigationItem = destination.navigationBar.topItem;
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];

    [source switchToContentViewController:destination];
    [source addContentViewController:destination withIdentifier:self.identifier];
    
}
@end
