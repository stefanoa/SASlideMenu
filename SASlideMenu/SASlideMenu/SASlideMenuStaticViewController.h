//
//  SASlideMenuStaticViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/29/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuDataSource.h"

#define kSlideInInterval 0.3
#define kSlideOutInterval 0.1
#define kVisiblePortion 50
#define kMenuTableWidth 280

@interface SASlideMenuStaticViewController : UITableViewController <UIGestureRecognizerDelegate>

@property (nonatomic) int menuTableVisibleWidth;
@property (assign, nonatomic) NSObject<SASlideMenuDataSource>* slideMenuDataSource;


-(void) switchToContentViewController:(UIViewController*) content;
-(void) doSlideToSide;

@end
