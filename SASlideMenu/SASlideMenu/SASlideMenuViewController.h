//
//  SASlideMenuViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/29/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuDataSource.h"
#import "SASlideMenuButton.h"

#define kSlideCompletelyOutInterval 0.2
#define kSlideOutInterval 0.2
#define kSlideInInterval 0.4
#define kStartUpAnimation 1.5
#define kVisiblePortion 40


@interface SASlideMenuViewController : UIViewController <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, SASlideMenuButtonDelegate>

@property (weak, nonatomic) IBOutlet UITableView* slideMenuTableView;

@property (weak, nonatomic) IBOutlet UIView* startUpView;

@property (strong, nonatomic) NSString* activeItemId;

@property (strong, nonatomic) NSObject<SASlideMenuDataSource>* slideMenuDataSource;

-(void) switchToContentViewController:(UIViewController*) content;
-(void) addContentViewController:(UIViewController*) content withIdentifier:(NSString*)identifier;

@end
