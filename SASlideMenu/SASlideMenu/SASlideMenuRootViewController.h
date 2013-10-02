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
@interface SASlideMenuRootViewController : UIViewController


@property (nonatomic,strong) SASlideMenuViewController* leftMenu;
@property (nonatomic,strong) UIViewController* rightMenu;
@property (nonatomic,assign) Boolean isRightMenuEnabled;
@property (nonatomic,strong) SASlideMenuNavigationController* navigationController;

@property (nonatomic,strong) IBOutlet UIView* menuView;

-(void) switchToContentViewController:(UINavigationController*) content completion:(void (^)(void))completion;
-(void) addContentViewController:(UIViewController*) content withIndexPath:(NSIndexPath*)indexPath;

-(void) popRightNavigationController;
-(void) pushRightNavigationController:(SASlideMenuNavigationController*)navigationController;

-(UINavigationController*) controllerForIndexPath:(NSIndexPath*) indexPath;

-(void) doSlideToSide;
-(void) doSlideToLeftSide;
-(void) rightMenuAction;
-(void) addRightMenu;

-(void) panItem:(UIPanGestureRecognizer*)gesture;
@end
