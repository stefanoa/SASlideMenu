//
//  SASlideMenuItemViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/30/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuViewController.h"

@interface SASlideMenuItemViewController : UINavigationController{
    UIButton* menuButton;
}

@property(nonatomic, strong) NSObject<SASlideMenuViewControllerDelegate>* slideMenuDelegate;

- (void) slideMenuButtonTouched;

@end
