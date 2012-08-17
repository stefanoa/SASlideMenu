//
//  SASlideMenuViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/29/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuDataSource.h"

#define kSlideInInterval 0.3
#define kSlideOutInterval 0.1
#define kVisiblePortion 40


@interface SASlideMenuViewController : UIViewController <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView* slideMenuTableView;
@property (assign, nonatomic) NSObject<SASlideMenuDataSource>* slideMenuDataSource;

@property (strong, nonatomic) NSString* activeItemId;


-(void) switchToContentViewController:(UIViewController*) content;
-(void) addContentViewController:(UIViewController*) content withIdentifier:(NSString*)identifier;
-(void) doSlideOut;

@end
