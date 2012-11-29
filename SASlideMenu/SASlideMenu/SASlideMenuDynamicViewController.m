//
//  SASlideMenuDynamicViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/20/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuDynamicViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kSlideInInterval 0.3
#define kSlideOutInterval 0.1
#define kVisiblePortion 40
#define kMenuTableSize 280
typedef enum {
    SASlideMenuStateContent,
    SASlideMenuStateMenu,
    SASlideMenuStateRightMenu
} SASlideMenuState;

typedef enum {
    SASlideMenuPanningStateStopped,
    SASlideMenuPanningStateRight,
    SASlideMenuPanningStateLeft
} SASlideMenuPanningState;

@interface SASlideMenuDynamicViewController (){
    UINavigationController* selectedContent;
    BOOL isFirstViewWillAppear;
    SASlideMenuState state;
    SASlideMenuPanningState panningState;
    CGFloat slideMenuVisibleWidth;
    
}

@property (nonatomic, strong) UIView* shield;
@property (nonatomic, strong) UIView* shieldWithMenu;

@end

@implementation SASlideMenuDynamicViewController

@synthesize slideMenuDataSource;
@synthesize controllers;

#pragma mark -
#pragma mark - SASlideMenuDynamicViewController

-(void) slideOut:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    controller.view.frame = CGRectMake(bounds.size.width,0.0,bounds.size.width,bounds.size.height);
}

-(void) slideToLeftSide:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    controller.view.frame = CGRectMake(kVisiblePortion-bounds.size.width,0.0,bounds.size.width,bounds.size.height);
}

-(void) slideToSide:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    controller.view.frame = CGRectMake(kMenuTableSize,0.0,bounds.size.width,bounds.size.height);
}

-(void) slideIn:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    controller.view.frame = CGRectMake(0.0,0.0,bounds.size.width,bounds.size.height);
}

-(void) completeSlideIn:(UINavigationController*) controller{
    [self.shieldWithMenu removeFromSuperview];
    
    [controller.visibleViewController.view addSubview:self.shield];
    self.shield.frame = controller.visibleViewController.view.bounds;
    state = SASlideMenuStateContent;
}

-(void) completeSlideToSide:(UINavigationController*) controller{
    [self.shield removeFromSuperview];
    [controller.view addSubview:self.shieldWithMenu];
    self.shieldWithMenu.frame = controller.view.bounds;
    state = SASlideMenuStateMenu;
    
}

-(void) completeSlideToLeftSide:(UINavigationController*) controller{
    [self.shield removeFromSuperview];
    [controller.view addSubview:self.shieldWithMenu];
    self.shieldWithMenu.frame = controller.view.bounds;
    state = SASlideMenuStateRightMenu;
}

-(void) doSlideToSide{
    [UIView animateWithDuration:kSlideInInterval
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
        [self slideToSide:selectedContent];
    }
                     completion:^(BOOL finished) {
        [self completeSlideToSide:selectedContent];
    }];
}
-(void) addRightMenu{
    CGRect bounds = self.view.bounds;
    CGRect frame  = CGRectMake(kVisiblePortion, 0, bounds.size.width-kVisiblePortion, bounds.size.height);
    self.rightMenu.view.frame = frame;
    [self addChildViewController:self.rightMenu];
    [self.view insertSubview:self.rightMenu.view belowSubview:selectedContent.view];
    state = SASlideMenuStateRightMenu;
}

-(void) rightMenuAction{
    [self addRightMenu];
    [self doSlideToLeftSide];
}

-(void) doSlideToLeftSide{
   
    [UIView animateWithDuration:kSlideInInterval
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         [self slideToLeftSide:selectedContent];
                     }
                     completion:^(BOOL finished) {
                         [self completeSlideToLeftSide:selectedContent];
                     }];
}

-(void) doSlideOut:(void (^)(BOOL completed))completion{
    [UIView animateWithDuration:kSlideOutInterval delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
        [self slideOut:selectedContent];
    } completion:completion];
}

-(void) doSlideIn:(void (^)(BOOL completed))completion{
    [UIView animateWithDuration:kSlideInInterval delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
        [self slideIn:selectedContent];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);            
        }
        if (state == SASlideMenuStateRightMenu) {
            [self.rightMenu willMoveToParentViewController:nil];
            [self.rightMenu.view removeFromSuperview];
            [self.rightMenu removeFromParentViewController];
        }
        [self completeSlideIn:selectedContent];
    }];
}

-(void) tapShield:(UITapGestureRecognizer*)gesture{
    [self doSlideIn:nil];
}
-(void) tapItem:(UITapGestureRecognizer*)gesture{
    [self switchToContentViewController:selectedContent];
}

-(void) panItem:(UIPanGestureRecognizer*)gesture{
    UIView* panningView = gesture.view;
    CGPoint translation = [gesture translationInView:panningView];
    UIView* movingView = selectedContent.view;
    if ([gesture state] == UIGestureRecognizerStateBegan) {
        if (movingView.frame.origin.x + translation.x < 0 ) {
            panningState = SASlideMenuPanningStateLeft;
            [self addRightMenu];
        }else{
            panningState = SASlideMenuPanningStateRight;
        }
    }
    
    if (movingView.frame.origin.x + translation.x < 0 ) {
        if (panningState == SASlideMenuPanningStateRight) {
            translation.x =0.0;
        }
    }
    if (movingView.frame.origin.x+translation.x >0) {
        if (state == SASlideMenuStateRightMenu || panningState == SASlideMenuPanningStateLeft) {
            translation.x =0.0;
        }
    }
    if ((-movingView.frame.origin.x-translation.x)>(self.view.frame.size.width-kVisiblePortion)) {
        if (panningState == SASlideMenuPanningStateLeft) {
            translation.x = kVisiblePortion- self.view.frame.size.width-movingView.frame.origin.x;
        }
    }
    [movingView setCenter:CGPointMake([movingView center].x + translation.x, [movingView center].y)];
    [gesture setTranslation:CGPointZero inView:[panningView superview]];
    if ([gesture state] == UIGestureRecognizerStateEnded){
        CGFloat pcenterx = movingView.center.x;
        CGRect bounds = self.view.bounds;
        CGSize size = bounds.size;
        if (panningState == SASlideMenuPanningStateRight) {
            if (pcenterx > size.width ) {
                [self doSlideToSide];
            }else{
                [self doSlideIn:nil];
            }
        }
        if (panningState == SASlideMenuPanningStateLeft) {
            if (pcenterx < 0 ) {
                [self doSlideToLeftSide];
            }else{
                [self doSlideIn:nil];
            }
        }

	}
}

-(void) switchToContentViewController:(UINavigationController*) content{
    CGRect bounds = self.view.bounds;
    self.view.userInteractionEnabled = NO;

    [self prepareForSwitchToContentViewController:content];

    Boolean slideOutThenIn = NO;
    if ([slideMenuDataSource respondsToSelector:@selector(slideOutThenIn)]){
        slideOutThenIn = [slideMenuDataSource slideOutThenIn];
    }
    
    if (slideOutThenIn) {
        //Animate out the currently selected UIViewController
        [self doSlideOut:^(BOOL completed) {
            [selectedContent willMoveToParentViewController:nil];
            [selectedContent.view removeFromSuperview];
            [selectedContent removeFromParentViewController];
            
            content.view.frame = CGRectMake(bounds.size.width,0,bounds.size.width,bounds.size.height);
            [self addChildViewController:content];
            [self.view addSubview:content.view];
            selectedContent = content;
            [self doSlideIn:^(BOOL completed) {
                [content didMoveToParentViewController:self];
                self.view.userInteractionEnabled = YES;
            }];
        }];
    }else{
        [selectedContent willMoveToParentViewController:nil];
        [selectedContent.view removeFromSuperview];
        [selectedContent removeFromParentViewController];
        [self slideToSide:content];
        [self addChildViewController:content];
        [self.view addSubview:content.view];
        selectedContent = content;
        [self doSlideIn:^(BOOL completed) {
            [content didMoveToParentViewController:self];
            self.view.userInteractionEnabled = YES;
        }];
    }    
}


-(void) addContentViewController:(UIViewController*) content withIndexPath:(NSIndexPath*)indexPath{
    Boolean allowContentViewControllerCaching = YES;
    if (indexPath) {
        if ([slideMenuDataSource respondsToSelector:@selector(allowContentViewControllerCachingForIndexPath:)]) {
            allowContentViewControllerCaching = [slideMenuDataSource allowContentViewControllerCachingForIndexPath:indexPath];
        }
        if (allowContentViewControllerCaching) {
            [self.controllers setObject:content forKey:indexPath];
        }
    }
}

-(void) prepareForSwitchToContentViewController:(UIViewController*) content{}

#pragma mark -
#pragma mark - UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndexPath = indexPath;
    UINavigationController* content = [self.controllers objectForKey:indexPath];
    if (content) {
        [self switchToContentViewController:content];
    }else{
        NSString* segueId = [self.slideMenuDataSource sugueIdForIndexPath:indexPath];
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:segueId sender:cell];
    }
}

#pragma mark -
#pragma mark - UIViewController

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (isFirstViewWillAppear) {
        NSString* identifier= [slideMenuDataSource initialSegueId];
        [self performSegueWithIdentifier:identifier sender:self];
        isFirstViewWillAppear = NO;
    }
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    isFirstViewWillAppear = YES;
    controllers = [[NSMutableDictionary alloc] init];
    self.shield = [[UIView alloc] initWithFrame:CGRectZero];
    self.shieldWithMenu = [[UIView alloc] initWithFrame:CGRectZero];
    state = SASlideMenuStateMenu;
    panningState = SASlideMenuPanningStateStopped;
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShield:)];
    [self.shieldWithMenu addGestureRecognizer:tapGesture];
    [tapGesture setDelegate:self];
    UIPanGestureRecognizer* panGestureMenu = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panItem:)];
    [panGestureMenu setMaximumNumberOfTouches:2];
    [panGestureMenu setDelegate:self];
    [self.shieldWithMenu addGestureRecognizer:panGestureMenu];

    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panItem:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [self.shield addGestureRecognizer:panGesture];
    
    if ([self.slideMenuDataSource respondsToSelector:@selector(slideMenuVisibleWidth)]) {
        slideMenuVisibleWidth = [self.slideMenuDataSource slideMenuVisibleWidth];
    }else{
        slideMenuVisibleWidth = kMenuTableSize;
    }

    [self performSegueWithIdentifier:@"rightMenu" sender:self];
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self.controllers removeAllObjects];
}


@end
