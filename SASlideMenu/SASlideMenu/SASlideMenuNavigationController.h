//
//  SASlideMenuNavigationControllerViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 2/6/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuRootViewController.h"

@interface SASlideMenuNavigationController : UINavigationController

@property (nonatomic,strong) SASlideMenuRootViewController* rootController;
@property (nonatomic,strong) UIViewController* lastController;
@end
