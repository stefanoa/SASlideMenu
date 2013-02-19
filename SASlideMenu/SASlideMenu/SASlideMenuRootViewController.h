//
//  SASlideMenuRootViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 1/16/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuViewController.h"

@class SASlideMenuNavigationController;
@class SASlideMenuViewController;
@interface SASlideMenuRootViewController : UIViewController<UITableViewDelegate>


@property (strong, nonatomic) SASlideMenuViewController* leftMenu;
@property (strong, nonatomic) UIViewController* rightMenu;
@property (assign, nonatomic) Boolean isRightMenuEnabled;
@property (strong, nonatomic) SASlideMenuNavigationController* navigationController;

-(void) switchToContentViewController:(UINavigationController*) content;
-(void) addContentViewController:(UIViewController*) content withIndexPath:(NSIndexPath*)indexPath;

-(void) popRightNavigationController;
-(void) pushRightNavigationController:(SASlideMenuNavigationController*)navigationController;

-(UINavigationController*) controllerForIndexPath:(NSIndexPath*) indexPath;

-(void) doSlideToSide;
-(void) rightMenuAction;



@end
