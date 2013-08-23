//
//  GreenViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 8/23/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuViewController.h"

@interface GreenViewController : UIViewController

@property(nonatomic,strong) SASlideMenuViewController* menuController;

-(IBAction)tap:(id)sender;

@end
