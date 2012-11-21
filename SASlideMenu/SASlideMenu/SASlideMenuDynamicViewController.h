//
//  SASlideMenuDynamicViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/20/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuDataSource.h"

#define kSlideInInterval 0.3
#define kSlideOutInterval 0.1
#define kVisiblePortion 40
#define kMenuTableSize 280

@interface SASlideMenuDynamicViewController : UIViewController <UIGestureRecognizerDelegate,UITableViewDelegate>

@property (assign, nonatomic) NSObject<SASlideMenuDataSource>* slideMenuDataSource;
@property (strong, nonatomic) NSMutableDictionary* controllers;
@property (strong, nonatomic) IBOutlet UITableView* tableView;


-(void) switchToContentViewController:(UIViewController*) content;
-(void) addContentViewController:(UIViewController*) content withIdentifier:(NSString*)identifier;
-(void) doSlideOut;

-(void) prepareForSwitchToContentViewController:(UIViewController*) content;
@end
