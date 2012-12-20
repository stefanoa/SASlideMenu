//
//  SASlideMenuDynamicViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/20/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuDataSource.h"
#import "SASlideMenuDelegate.h"

@interface SASlideMenuDynamicViewController : UIViewController <UIGestureRecognizerDelegate,UITableViewDelegate>

@property (assign, nonatomic) NSObject<SASlideMenuDataSource>* slideMenuDataSource;
@property (assign, nonatomic) NSObject<SASlideMenuDelegate>* slideMenuDelegate;

@property (strong, nonatomic) NSMutableDictionary* controllers;
@property (strong, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) UINavigationController* rightMenu;
@property (strong, nonatomic) NSIndexPath* selectedIndexPath;

-(void) switchToContentViewController:(UINavigationController*) content;
-(void) addContentViewController:(UIViewController*) content withIndexPath:(NSIndexPath*)indexPath;
-(void) doSlideToSide;
-(void) rightMenuAction;

-(void) prepareForSwitchToContentViewController:(UIViewController*) content;
@end
