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
@interface SASlideMenuRootViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate>


@property (strong, nonatomic) SASlideMenuViewController* leftMenu;
@property (strong, nonatomic) UIViewController* rightMenu;
@property (assign, nonatomic) Boolean isRightMenuEnabled;
@property (strong, nonatomic) SASlideMenuNavigationController* navigationController;

-(void) switchToContentViewController:(UINavigationController*) content animated:(Boolean) animated;
-(void) addContentViewController:(UIViewController*) content withIndexPath:(NSIndexPath*)indexPath;
-(void) popNavigationController;
-(void) pushNavigationController:(SASlideMenuNavigationController*)navigationController;

-(void) doSlideToSide;
-(void) rightMenuAction;



@end
