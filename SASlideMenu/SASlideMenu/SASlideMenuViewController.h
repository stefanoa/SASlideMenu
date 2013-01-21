//
//  SASlideMenuViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 1/17/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuDataSource.h"
#import "SASlideMenuDelegate.h"

@class SASlideMenuRootViewController;

@interface SASlideMenuViewController : UITableViewController

@property(nonatomic,strong) SASlideMenuRootViewController* rootController;
@property (assign, nonatomic) NSObject<SASlideMenuDataSource>* slideMenuDataSource;
@property (assign, nonatomic) NSObject<SASlideMenuDelegate>* slideMenuDelegate;

@end
