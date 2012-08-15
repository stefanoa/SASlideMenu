//
//  SASlideMenuItemViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/30/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuItemViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SASlideMenuItemViewController ()

@end

@implementation SASlideMenuItemViewController

@synthesize slideMenuDelegate;

-(void) viewDidLoad{
    [super viewDidLoad];
    
    menuButton   =   [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 29)];
    [menuButton setImage:[UIImage imageNamed:@"menuicon.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
    [menuButton setAdjustsImageWhenHighlighted:NO];
    [menuButton setAdjustsImageWhenDisabled:NO];
    [menuButton addTarget:self action:@selector(slideMenuButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UINavigationItem* navigationItem = self.navigationBar.topItem;
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
}

- (void) slideMenuButtonTouched{
    menuButton.highlighted = NO;    
    [slideMenuDelegate activateSlideMenuFromItem:self];
}

@end
