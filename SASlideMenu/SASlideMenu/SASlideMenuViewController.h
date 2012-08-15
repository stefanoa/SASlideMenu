//
//  SASlideMenuViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/29/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuDataSource.h"

#define kSlideCompletelyOutInterval 0.2
#define kSlideOutInterval 0.2
#define kSlideInInterval 0.4
#define kStartUpAnimation 1.5
#define kVisiblePortion 40
@class SASlideMenuItemViewController;

@protocol SASlideMenuViewControllerDelegate <NSObject>

-(void) activateSlideMenuFromItem:(SASlideMenuItemViewController*) slideMenuItemViewController;

@end

@interface SASlideMenuViewController : UIViewController <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, SASlideMenuViewControllerDelegate>{
    BOOL isFirstViewWillAppear;
}

@property (weak, nonatomic) IBOutlet UITableView* slideMenuTableView;
@property (weak, nonatomic) IBOutlet UIImageView* screenShotImageView;
@property (weak, nonatomic) IBOutlet UIView* startUpView;

@property (assign, nonatomic) BOOL segueWillSlideOut;
@property (strong, nonatomic) NSString* activeItemId;
@property (strong, nonatomic) UITapGestureRecognizer* tapGesture;
@property (strong, nonatomic) UIPanGestureRecognizer* panGesture;

@property (strong, nonatomic) NSObject<SASlideMenuDataSource>* slideMenuDataSource;


@end
