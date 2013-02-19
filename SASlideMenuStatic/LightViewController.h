//
//  LightViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 2/18/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuRootViewController.h"

@interface LightViewController : UIViewController

@property (nonatomic,strong) SASlideMenuViewController* menuViewController;

-(IBAction)tap:(id)sender;
@end
