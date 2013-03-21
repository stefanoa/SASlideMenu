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

@interface SASlideMenuViewController : UIViewController<UIGestureRecognizerDelegate>

@property(nonatomic,strong) SASlideMenuRootViewController          * rootController;

@property(nonatomic,strong) IBOutlet id <SASlideMenuDataSource> slideMenuDataSource;
@property(nonatomic,strong) IBOutlet id <SASlideMenuDelegate>   slideMenuDelegate;
@property(nonatomic,readonly) NSIndexPath  * indexPathForSelectedRow;

-(void)selectContentAtIndexPath:(NSIndexPath *)indexPath;

@end
