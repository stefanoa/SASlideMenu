//
//  SASlideMenuDataSource.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/30/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//


@protocol SASlideMenuDataSource <NSObject>

@optional
//It is used to prepare the Content View Controller before it will be displayed.
//It is called for each selection of the menu.
-(void) prepareForSwitchToContentViewController:(UINavigationController *)content;

//Maps menu rows to segueId. It is a required method for table with dynamic cell prototype.
//It is also required if you want to use static table but you need to cache content view controllers.
-(NSString*) segueIdForIndexPath:(NSIndexPath*) indexPath;

//It returns the initially selected menu row. If not implemented the menu is initially displayed without selection.
-(NSIndexPath*) selectedIndexPath;

// It is used to provide a custom configuration for the menu button.
-(void) configureMenuButton:(UIButton*) menuButton;

// It is used to selectively activate the right menu button. It is a mandatory method if you need a right button.
-(Boolean) hasRightMenuForIndexPath:(NSIndexPath*) indexPath;
// It is used to provide a custom configuration for the right menu button. It is a mandatory method if you need a right button.
-(void) configureRightMenuButton:(UIButton*) menuButton;

// It is used to provide a custom configuration for the content CALayer, useful to change shadow style.
-(void) configureSlideLayer:(CALayer*) layer;

// The duration of the animation
-(CGFloat) slideInAnimationDuration;

// The duration of the animation
-(CGFloat) slideOutAnimationDuration;

// The visibile widht of the left menu
-(CGFloat) leftMenuVisibleWidth;

// The visibile widht of the right menu
-(CGFloat) rightMenuVisibleWidth;

// If it returns true when switching between content view controller the deselected one will slide out before the selected one will slide in.
-(Boolean) slideOutThenIn;

// It is used to selectively disable content view controller caching. If not implemented the view controller are cached.
-(Boolean) disableContentViewControllerCachingForIndexPath:(NSIndexPath*) indexPath;

// It is used to selectively disable the pan gesture that slide the view controller. If not implemented the pan gesture is active for all the view controller.
-(Boolean) disablePanGestureForIndexPath:(NSIndexPath*) indexPath;

// It is used to enable the pan gesture that slide the view controller only on certain view zones. If not implemented the pan gesture is active for the entier view.
-(Boolean) shouldRespondToGesture:(UIGestureRecognizer*) gesture forIndexPath:(NSIndexPath*)indexPath;
@end
