//
//  SASlideMenuRootViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 1/16/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuRootViewController.h"
#import "SASlideMenuNavigationController.h"
#import "SASlideMenuRightMenuViewController.h"

#define kMenuTableSize 280
#define kSwipeMinDetectionSpeed 0.1f


typedef enum {
    SASlideMenuStateInitial,
    SASlideMenuStateContent,
    SASlideMenuStateMenu,
    SASlideMenuStateRightMenu
} SASlideMenuState;

typedef enum {
    SASlideMenuPanningStateStopped,
    SASlideMenuPanningStateRight,
    SASlideMenuPanningStateLeft
} SASlideMenuPanningState;

@interface SASlideMenuRootViewController (){
    SASlideMenuState state;
    SASlideMenuPanningState panningState;
    CGFloat panningPreviousPosition;
    NSDate* panningPreviousEventDate;
    CGFloat panningXSpeed;  // panning speed expressed in px/ms 
    NSMutableDictionary* controllers;
    
    UIPanGestureRecognizer* menuPanGesture;
    UITapGestureRecognizer* tapGesture;
}

@property (nonatomic,strong) UINavigationController* selectedContent;
@property (nonatomic, strong) UIView* shieldWithMenu;

@end

#define kSlideInInterval 0.3
#define kSlideOutInterval 0.1
#define kMenuTableSize 280

@implementation SASlideMenuRootViewController

@synthesize menuView;

#pragma mark -
#pragma mark SASlideMenuRootViewController

-(CGFloat) leftMenuSize{
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(leftMenuVisibleWidth)]){
        return [self.leftMenu.slideMenuDataSource leftMenuVisibleWidth];
    }else{
        return kMenuTableSize;
    }
}
-(CGFloat) rightMenuSize{
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(rightMenuVisibleWidth)]){
        return [self.leftMenu.slideMenuDataSource rightMenuVisibleWidth];
    }else{
        return kMenuTableSize;
    }
}
-(void) slideOut:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    controller.view.frame = CGRectMake(bounds.size.width,0.0,bounds.size.width,bounds.size.height);
}
-(void) slideToLeftSide:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    CGFloat menuSize = [self rightMenuSize];
    controller.view.frame = CGRectMake(-menuSize,0.0,bounds.size.width,bounds.size.height);
}
-(void) slideToSide:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    CGFloat menuSize = [self leftMenuSize];
    controller.view.frame = CGRectMake(menuSize,0.0,bounds.size.width,bounds.size.height);
}

-(void) slideIn:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    controller.view.frame = CGRectMake(0.0,0.0,bounds.size.width,bounds.size.height);
}
-(void) addShield:(UINavigationController*) controller{
    [controller.view addSubview:self.shieldWithMenu];
    self.shieldWithMenu.frame = controller.view.bounds;

}
-(void) removeShield:(UINavigationController*) controller{
    [self.shieldWithMenu removeFromSuperview];
}

-(void) completeSlideIn:(UINavigationController*) controller{
    [self removeShield:controller];
    state = SASlideMenuStateContent;
}

-(void) completeSlideToSide:(UINavigationController*) controller{
    [self addShield:controller];
    state = SASlideMenuStateMenu;
    
}

-(void) completeSlideToLeftSide:(UINavigationController*) controller{
    [self addShield:controller];
    state = SASlideMenuStateRightMenu;
}

-(void) doSlideToSide{
    if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuWillSlideToSide:)]){
        [self.leftMenu.slideMenuDelegate slideMenuWillSlideToSide:self.selectedContent];
    }
    [self disableGestureRecognizers];
    CGFloat duration = kSlideInInterval;
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(slideInAnimationDuration)]) {
        duration = [self.leftMenu.slideMenuDataSource slideInAnimationDuration];
    }
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self slideToSide:self.selectedContent];
                     }
                     completion:^(BOOL finished) {
                         [self completeSlideToSide:self.selectedContent];
                         if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuDidSlideToSide:)]){
                             [self.leftMenu.slideMenuDelegate slideMenuDidSlideToSide:self.selectedContent];
                         }
                         [self enableGestureRecognizers];
                     }];
}

-(void) doSlideToLeftSide{
    if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuWillSlideToLeft:)]){
        [self.leftMenu.slideMenuDelegate slideMenuWillSlideToLeft:self.selectedContent];
    }
    [self disableGestureRecognizers];
    CGFloat duration = kSlideInInterval;
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(slideInAnimationDuration)]) {
        duration = [self.leftMenu.slideMenuDataSource slideInAnimationDuration];
    }

    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self slideToLeftSide:self.selectedContent];
                     }
                     completion:^(BOOL finished) {
                         [self completeSlideToLeftSide:self.selectedContent];
                         if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuDidSlideToLeft:)]){
                             [self.leftMenu.slideMenuDelegate slideMenuDidSlideToLeft:self.selectedContent];
                         }
                         [self enableGestureRecognizers];
                     }];
}

-(void) doSlideOut:(void (^)(BOOL completed))completion{
    if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuWillSlideOut:)]){
        [self.leftMenu.slideMenuDelegate slideMenuWillSlideOut:self.selectedContent];
    }
    [self disableGestureRecognizers];
    CGFloat duration = kSlideOutInterval;

    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(slideOutAnimationDuration)]) {
        duration = [self.leftMenu.slideMenuDataSource slideOutAnimationDuration];
    }
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self slideOut:self.selectedContent];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
        if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuDidSlideOut:)]){
            [self.leftMenu.slideMenuDelegate slideMenuDidSlideOut:self.selectedContent];
        }
        [self enableGestureRecognizers];
    }];
}

-(void) doSlideIn:(void (^)(BOOL completed))completion{
    if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuWillSlideIn:)]){
        [self.leftMenu.slideMenuDelegate slideMenuWillSlideIn:self.selectedContent];
    }
    [self disableGestureRecognizers];
    CGFloat duration = kSlideInInterval;
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(slideInAnimationDuration)]) {
        duration = [self.leftMenu.slideMenuDataSource slideInAnimationDuration];
    }
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self slideIn:self.selectedContent];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
        if (panningState == SASlideMenuPanningStateLeft
            || state == SASlideMenuStateRightMenu) {
            [self removeRightMenu];
        }
        [self completeSlideIn:self.selectedContent];
        if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuDidSlideIn:)]){
            [self.leftMenu.slideMenuDelegate slideMenuDidSlideIn:self.selectedContent];
        }
        [self enableGestureRecognizers];
    }];
}

- (void)disableGestureRecognizers {
    [tapGesture setEnabled:NO];
    [menuPanGesture setEnabled:NO];
}

- (void)enableGestureRecognizers {
    [tapGesture setEnabled:YES];
    [menuPanGesture setEnabled:YES];
}

-(void) addRightMenu{
    CGRect bounds = self.view.bounds;
    CGFloat menuSize = [self rightMenuSize];
    
    CGFloat visiblePortion = bounds.size.width-menuSize;
    CGRect frame  = CGRectMake(visiblePortion, 0, menuSize, bounds.size.height);
    self.rightMenu.view.frame = frame;
    self.rightMenu.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight;
    
    [self addChildViewController:self.rightMenu];
    [self.view insertSubview:self.rightMenu.view belowSubview:self.selectedContent.view];
}

- (void)removeRightMenu {
    [self.rightMenu willMoveToParentViewController:nil];
    [self.rightMenu.view removeFromSuperview];
    [self.rightMenu removeFromParentViewController];
}

-(void) rightMenuAction{
    [self addRightMenu];
    [self doSlideToLeftSide];
}

-(void) tapShield:(UITapGestureRecognizer*)gesture{
    [self doSlideIn:nil];
}
-(void) tapItem:(UITapGestureRecognizer*)gesture{
    [self switchToContentViewController:self.selectedContent completion:nil];
}

-(void) panItem:(UIPanGestureRecognizer*)gesture{    
    UIView* panningView = gesture.view;
    CGPoint translation = [gesture translationInView:panningView];
    UIView* movingView = self.selectedContent.view;
    
    if ([gesture state] == UIGestureRecognizerStateBegan) {

        if (movingView.frame.origin.x + translation.x < 0 ) {
            if (self.isRightMenuEnabled && self.rightMenu != nil) {
                panningState = SASlideMenuPanningStateLeft;
                [self addRightMenu];
            }else{
                translation.x = 0.0;
                panningState = SASlideMenuPanningStateRight;
            }
        }else{
            panningState = SASlideMenuPanningStateRight;
        }
    } else if ([gesture state] == UIGestureRecognizerStateEnded){
        //Decide on which side to slide the view
        //There are 2 conditions to slide the view on a side :
        //  - The move speed is high enough.
        //  - The move speed is not high enough, but the view has been dragged more than half of the way to the side.
        CGFloat originx = movingView.frame.origin.x;
        if (panningState == SASlideMenuPanningStateRight) {
            if (panningXSpeed < -kSwipeMinDetectionSpeed) {
                [self doSlideIn:nil];
            } else if (panningXSpeed > kSwipeMinDetectionSpeed) {
                [self doSlideToSide];
            } else if (originx < [self leftMenuSize] / 2.0f) {
                [self doSlideIn:nil];
            } else {
                [self doSlideToSide];
            }
        }
        if (panningState == SASlideMenuPanningStateLeft) {
            if (panningXSpeed > kSwipeMinDetectionSpeed) {
                [self doSlideIn:nil];
            } else if (panningXSpeed < -kSwipeMinDetectionSpeed) {
                [self doSlideToLeftSide];
            } else if (originx > -[self rightMenuSize] / 2.0f) {
                [self doSlideIn:nil];
            } else {
                [self doSlideToLeftSide];
            }
        }
    } else {
        //when showing the left menu
        if (panningState == SASlideMenuPanningStateRight) {
            if (movingView.frame.origin.x + translation.x < 0 ) {
                //cap min left to 0
                translation.x = 0.0;
            } else if (movingView.frame.origin.x + translation.x > [self leftMenuSize]) {
                //cap max left to leftMenuSize
                translation.x= 0.0;
            }
        }
        
        //when showing the right menu
        if (panningState == SASlideMenuPanningStateLeft) {
            if (movingView.frame.origin.x+translation.x > 0) {
                //cap the min left to 0
                translation.x = 0.0;
            } else if (movingView.frame.origin.x + translation.x < -[self rightMenuSize]) {
                //cap the max left to -rightMenuSize
                translation.x = 0.0;
            }
        }
        
        [movingView setCenter:CGPointMake([movingView center].x + translation.x, [movingView center].y)];
        [gesture setTranslation:CGPointZero inView:[panningView superview]];
        
        //calculate pan move speed
        if (panningPreviousEventDate != nil) {
            CGFloat movement = movingView.frame.origin.x - panningPreviousPosition;
            NSTimeInterval movementDuration = [[NSDate date] timeIntervalSinceDate:panningPreviousEventDate] * 1000.0f;
            panningXSpeed = movement / movementDuration;
        }
        panningPreviousEventDate = [NSDate date];
        panningPreviousPosition = movingView.frame.origin.x;
    }
}

-(UINavigationController*) controllerForIndexPath:(NSIndexPath*) indexPath{
    return [controllers objectForKey:indexPath];
}

-(void) switchToContentViewController:(UINavigationController*) content completion:(void (^)(void))completion{
    CGRect bounds = self.view.bounds;
    self.view.userInteractionEnabled = NO;
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(prepareForSwitchToContentViewController:)]) {
        [self.leftMenu.slideMenuDataSource prepareForSwitchToContentViewController:content];
    }
    
    Boolean slideOutThenIn = NO;
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(slideOutThenIn)]){
        slideOutThenIn = [self.leftMenu.slideMenuDataSource slideOutThenIn];
    }
    BOOL hideContentOnStartup = ![self.leftMenu.slideMenuDataSource respondsToSelector:@selector(selectedIndexPath)];
    
    if (state != SASlideMenuStateInitial || hideContentOnStartup) {
        if (slideOutThenIn) {
            [self doSlideOut:^(BOOL completed) {
                [self.selectedContent willMoveToParentViewController:nil];
                [self.selectedContent.view removeFromSuperview];
                [self.selectedContent removeFromParentViewController];
                
                content.view.frame = CGRectMake(bounds.size.width,0,bounds.size.width,bounds.size.height);
                [self addChildViewController:content];
                [self.view addSubview:content.view];
                self.selectedContent = content;
                [self doSlideIn:^(BOOL slideInCompleted) {
                    [content didMoveToParentViewController:self];
                    if(completion){
                        completion();
                    }
                    self.view.userInteractionEnabled = YES;
                }];
            }];
        }else{
            [self.selectedContent willMoveToParentViewController:nil];
            [self.selectedContent.view removeFromSuperview];
            [self.selectedContent removeFromParentViewController];
            [self slideToSide:content];
            [self addChildViewController:content];
            [self.view addSubview:content.view];
            self.selectedContent = content;
            [self doSlideIn:^(BOOL completed) {
                [content didMoveToParentViewController:self];
                if(completion){
                    completion();
                }
                self.view.userInteractionEnabled = YES;
            }];
        }
        
    }else{
        [self.selectedContent willMoveToParentViewController:nil];
        [self.selectedContent.view removeFromSuperview];
        [self.selectedContent removeFromParentViewController];
        [self slideToSide:content];
        [self addChildViewController:content];
        [self.view addSubview:content.view];
        self.selectedContent = content;
        if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuWillSlideIn:)]){
            [self.leftMenu.slideMenuDelegate slideMenuWillSlideIn:self.selectedContent];
        }
        [self slideIn:self.selectedContent];
        if (state == SASlideMenuStateRightMenu) {
            [self.rightMenu willMoveToParentViewController:nil];
            [self.rightMenu.view removeFromSuperview];
            [self.rightMenu removeFromParentViewController];
        }
        [self completeSlideIn:self.selectedContent];
        if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuDidSlideIn:)]){
            [self.leftMenu.slideMenuDelegate slideMenuDidSlideIn:self.selectedContent];
        }
        [content didMoveToParentViewController:self];
        if(completion){
            completion();
        }
        self.view.userInteractionEnabled = YES;
    }
}

-(void) addContentViewController:(UIViewController*) content withIndexPath:(NSIndexPath*)indexPath{
    Boolean disableContentViewControllerCaching= NO;
    if (indexPath) {
        if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(disableContentViewControllerCachingForIndexPath:)]) {
            disableContentViewControllerCaching = [self.leftMenu.slideMenuDataSource disableContentViewControllerCachingForIndexPath:indexPath];
        }
        if (!disableContentViewControllerCaching) {
            [controllers setObject:content forKey:indexPath];
        }
    }
}

-(void) pushRightNavigationController:(SASlideMenuNavigationController*)navigationController{
    SASlideMenuRootViewController* root = self;
    root.navigationController = navigationController;
    navigationController.rootController = root;
    
    NSArray* ctrls = navigationController.viewControllers;
    UIViewController* empty = [[UIViewController alloc] init];
    NSArray* newControllers = [NSArray arrayWithObjects:empty,[ctrls objectAtIndex:0],nil];
    [navigationController setViewControllers:newControllers animated:NO];
    navigationController.lastController =[ctrls objectAtIndex:0];
    
    CGRect bounds = root.view.bounds;
    navigationController.view.frame = CGRectMake(bounds.size.width,0.0,bounds.size.width,bounds.size.height);
    [root addChildViewController:navigationController];
    [root.view addSubview:navigationController.view];
    CGFloat duration = kSlideInInterval;
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(slideInAnimationDuration)]) {
        duration = [self.leftMenu.slideMenuDataSource slideInAnimationDuration];
    }

    [UIView animateWithDuration:duration animations:^{
        navigationController.view.frame = CGRectMake(0.0,0.0,bounds.size.width,bounds.size.height);
    } completion:^(BOOL finished) {
        [navigationController didMoveToParentViewController:root];
    }];

}

-(void) popRightNavigationController{
    CGRect bounds = self.view.bounds;
    [self.navigationController willMoveToParentViewController:nil];
    CGFloat duration = kSlideInInterval;
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(slideInAnimationDuration)]) {
        duration = [self.leftMenu.slideMenuDataSource slideInAnimationDuration];
    }
    [UIView animateWithDuration:duration animations:^{
        self.navigationController.view.frame = CGRectMake(bounds.size.width, 0, bounds.size.width, bounds.size.height);
    } completion:^(BOOL finished) {
        [self.navigationController.view removeFromSuperview];
        [self.navigationController removeFromParentViewController];
    }];
}

#pragma mark -
#pragma mark UIViewController
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    CGRect bounds = self.view.bounds;
    CGFloat menuSize = [self rightMenuSize];
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        CGRect rightFrame = CGRectMake(bounds.size.width-menuSize, 0, menuSize, bounds.size.height);
        self.rightMenu.view.frame = rightFrame;
        self.shieldWithMenu.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    }
}

-(void) viewDidLoad{
    [super viewDidLoad];

    controllers = [[NSMutableDictionary alloc] init];
    
    self.shieldWithMenu = [[UIView alloc] initWithFrame:CGRectZero];
    state = SASlideMenuStateInitial;
    panningState = SASlideMenuPanningStateStopped;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShield:)];
    [self.shieldWithMenu addGestureRecognizer:tapGesture];
    
    menuPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panItem:)];
    [menuPanGesture setMaximumNumberOfTouches:2];
    [self.shieldWithMenu addGestureRecognizer:menuPanGesture];

    self.isRightMenuEnabled = NO;
    [self performSegueWithIdentifier:@"leftMenu" sender:self];
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [controllers removeAllObjects];
}


@end
