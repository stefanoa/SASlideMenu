//
//  ExampleDynamicMenuViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/20/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuDynamicViewController.h"
#import "SASlideMenuDataSource.h"

@interface ExampleDynamicMenuViewController : SASlideMenuDynamicViewController<SASlideMenuDataSource,UITableViewDataSource>

-(void) tap:(id) sender;
@end
