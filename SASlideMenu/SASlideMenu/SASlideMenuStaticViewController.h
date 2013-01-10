//
//  SASlideMenuStaticViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/29/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuDataSource.h"
#import "SASlideMenuDelegate.h"

#define kSlideInInterval 0.3
#define kSlideOutInterval 0.1
#define kVisiblePortion 40
#define kMenuTableSize 280

@interface SASlideMenuStaticViewController : UITableViewController <UIGestureRecognizerDelegate>

@property (assign, nonatomic) NSObject<SASlideMenuDataSource>* slideMenuDataSource;
@property (assign, nonatomic) NSObject<SASlideMenuDelegate>* slideMenuDelegate;


-(void) switchToContentViewController:(UIViewController*) content;
-(void) doSlideToSide;
-(void) doSlideIn:(void (^)(BOOL completed))completion;
-(void) doSlideOut:(void (^)(BOOL completed))completion;
@end
