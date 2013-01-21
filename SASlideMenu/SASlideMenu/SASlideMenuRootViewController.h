//
//  SASlideMenuRootViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 1/16/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuViewController.h"
@class SASlideMenuViewController;
@interface SASlideMenuRootViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate>


@property (strong, nonatomic) SASlideMenuViewController* leftMenu;
@property (strong, nonatomic) UIViewController* rightMenu;

@property (strong, nonatomic) NSIndexPath* selectedIndexPath;


-(void) switchToContentViewController:(UINavigationController*) content;
-(void) addContentViewController:(UIViewController*) content withIndexPath:(NSIndexPath*)indexPath;
-(void) doSlideToSide;
-(void) rightMenuAction;


@end
