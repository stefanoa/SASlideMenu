//
//  ExampleiPadViewController.h
//  SASlideMenuiPad
//
//  Created by Stefano Antonelli on 3/13/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuViewController.h"
#import "SASlideMenuDataSource.h"
#import "SASlideMenuDelegate.h"

@interface ExampleiPadViewController : SASlideMenuViewController<SASlideMenuDataSource,SASlideMenuDelegate, UITableViewDataSource>

@end
