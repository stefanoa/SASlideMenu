//
//  SASlideMenuNavigationControllerViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 2/6/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuNavigationController.h"

@interface SASlideMenuNavigationController ()

@end

@implementation SASlideMenuNavigationController

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if (self.topViewController == self.lastController) {
        [self.rootController popRightNavigationController];
        return nil;
    }else{
        return [super popViewControllerAnimated:animated];
    }
}

-(NSArray*) popToRootViewControllerAnimated:(BOOL)animated{
    NSArray* vcs = [super popToRootViewControllerAnimated:animated];
    [self.rootController popRightNavigationController];
    return vcs;
}
@end
