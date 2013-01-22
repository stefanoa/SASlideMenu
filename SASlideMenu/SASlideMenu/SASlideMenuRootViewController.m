//
//  SASlideMenuRootViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 1/16/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuRootViewController.h"

#define kSlideInInterval 0.3
#define kSlideOutInterval 0.1
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

@interface SASlideMenuRootViewController (){
    SASlideMenuState state;
    SASlideMenuPanningState panningState;
    NSMutableDictionary* controllers;
}

@property (nonatomic,strong) UINavigationController* selectedContent;
@property (nonatomic, strong) UIView* shield;
@property (nonatomic, strong) UIView* shieldWithMenu;

@end

#define kSlideInInterval 0.3
#define kSlideOutInterval 0.1
#define kMenuTableSize 280

@implementation SASlideMenuRootViewController

#pragma mark -
#pragma mark SASlideMenuRootViewController

-(CGFloat) menuSize{
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(slideMenuVisibleWidth)]){
        return [self.leftMenu.slideMenuDataSource slideMenuVisibleWidth];
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
    CGFloat menuSize = [self menuSize];
    controller.view.frame = CGRectMake(-menuSize,0.0,bounds.size.width,bounds.size.height);
}

-(void) slideToSide:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    CGFloat menuSize = [self menuSize];
    controller.view.frame = CGRectMake(menuSize,0.0,bounds.size.width,bounds.size.height);
}

-(void) slideIn:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    controller.view.frame = CGRectMake(0.0,0.0,bounds.size.width,bounds.size.height);
}

-(void) completeSlideIn:(UINavigationController*) controller{
    [self.shieldWithMenu removeFromSuperview];
    
    [controller.visibleViewController.view addSubview:self.shield];
    [controller.visibleViewController.view sendSubviewToBack:self.shield];
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
    if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuWillSlideToSide)]){
        [self.leftMenu.slideMenuDelegate slideMenuWillSlideToSide];
    }
    [UIView animateWithDuration:kSlideInInterval
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         [self slideToSide:self.selectedContent];
                     }
                     completion:^(BOOL finished) {
                         [self completeSlideToSide:self.selectedContent];
                         if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuDidSlideToSide)]){
                             [self.leftMenu.slideMenuDelegate slideMenuDidSlideToSide];
                         }
                         
                     }];
}

-(void) doSlideToLeftSide{
    if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuWillSlideToLeft)]){
        [self.leftMenu.slideMenuDelegate slideMenuWillSlideToLeft];
    }
    
    [UIView animateWithDuration:kSlideInInterval
                          delay:0.0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         [self slideToLeftSide:self.selectedContent];
                     }
                     completion:^(BOOL finished) {
                         [self completeSlideToLeftSide:self.selectedContent];
                         if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuDidSlideToLeft)]){
                             [self.leftMenu.slideMenuDelegate slideMenuDidSlideToLeft];
                         }
                         
                     }];
}

-(void) doSlideOut:(void (^)(BOOL completed))completion{
    if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuWillSlideOut)]){
        [self.leftMenu.slideMenuDelegate slideMenuWillSlideOut];
    }
    [UIView animateWithDuration:kSlideOutInterval delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
        [self slideOut:self.selectedContent];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
        if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuDidSlideOut)]){
            [self.leftMenu.slideMenuDelegate slideMenuDidSlideOut];
        }
        
    }];
}

-(void) doSlideIn:(void (^)(BOOL completed))completion{
    if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuWillSlideIn)]){
        [self.leftMenu.slideMenuDelegate slideMenuWillSlideIn];
    }
    [UIView animateWithDuration:kSlideInInterval delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
        [self slideIn:self.selectedContent];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
        if (state == SASlideMenuStateRightMenu) {
            [self.rightMenu willMoveToParentViewController:nil];
            [self.rightMenu.view removeFromSuperview];
            [self.rightMenu removeFromParentViewController];
        }
        [self completeSlideIn:self.selectedContent];
        if ([self.leftMenu.slideMenuDelegate respondsToSelector:@selector(slideMenuDidSlideIn)]){
            [self.leftMenu.slideMenuDelegate slideMenuDidSlideIn];
        }
        
    }];
}
-(void) addRightMenu{
    CGRect bounds = self.view.bounds;
    CGFloat menuSize = [self menuSize];
    
    CGFloat visiblePortion = bounds.size.width-menuSize;
    CGRect frame  = CGRectMake(visiblePortion, 0, menuSize, bounds.size.height);
    self.rightMenu.view.frame = frame;
    self.rightMenu.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight;
    
    [self addChildViewController:self.rightMenu];
    [self.view insertSubview:self.rightMenu.view belowSubview:self.selectedContent.view];
    state = SASlideMenuStateRightMenu;
}

-(void) rightMenuAction{
    [self addRightMenu];
    [self doSlideToLeftSide];
}

-(void) tapShield:(UITapGestureRecognizer*)gesture{
    [self doSlideIn:nil];
}
-(void) tapItem:(UITapGestureRecognizer*)gesture{
    [self switchToContentViewController:self.selectedContent];
}

-(void) panItem:(UIPanGestureRecognizer*)gesture{
    UIView* panningView = gesture.view;
    CGPoint translation = [gesture translationInView:panningView];
    UIView* movingView = self.selectedContent.view;
    if ([gesture state] == UIGestureRecognizerStateBegan) {
        if (movingView.frame.origin.x + translation.x < 0 ) {
            Boolean hasRightMenu = NO;
            if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(hasRightMenuForIndexPath:)] && self.rightMenu != nil) {
                hasRightMenu = [self.leftMenu.slideMenuDataSource hasRightMenuForIndexPath:self.selectedIndexPath];
            }

            if (hasRightMenu) {
                panningState = SASlideMenuPanningStateLeft;
                [self addRightMenu];
            }else{
                translation.x = 0.0;
                panningState = SASlideMenuPanningStateRight;
            }
        }else{
            panningState = SASlideMenuPanningStateRight;
        }
    }
    
    if (movingView.frame.origin.x + translation.x < 0 ) {
        if (panningState == SASlideMenuPanningStateRight) {
            translation.x =0.0;
        }
    }
    if (translation.x>0 && movingView.frame.origin.x >=[self menuSize]) {
        if (panningState == SASlideMenuPanningStateRight) {
            translation.x=0.0;
        }
    }
    if (movingView.frame.origin.x+translation.x >0) {
        if (state == SASlideMenuStateRightMenu || panningState == SASlideMenuPanningStateLeft) {
            translation.x =0.0;
        }
    }
    CGFloat menuSize = [self menuSize];
    CGRect bounds = self.view.bounds;
    CGPoint origin = movingView.frame.origin;
    CGFloat visiblePortion = bounds.size.width - menuSize;
    if ((-origin.x-translation.x)>(bounds.size.width-visiblePortion)) {
        if (panningState == SASlideMenuPanningStateLeft) {
            translation.x = visiblePortion- bounds.size.width-movingView.frame.origin.x;
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
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(prepareForSwitchToContentViewController:)]) {
        [self.leftMenu.slideMenuDataSource prepareForSwitchToContentViewController:content];
    }
    
    Boolean slideOutThenIn = NO;
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(slideOutThenIn)]){
        slideOutThenIn = [self.leftMenu.slideMenuDataSource slideOutThenIn];
    }
    
    if (slideOutThenIn) {
        //Animate out the currently selected UIViewController
        [self doSlideOut:^(BOOL completed) {
            [self.selectedContent willMoveToParentViewController:nil];
            [self.selectedContent.view removeFromSuperview];
            [self.selectedContent removeFromParentViewController];
            
            content.view.frame = CGRectMake(bounds.size.width,0,bounds.size.width,bounds.size.height);
            [self addChildViewController:content];
            [self.view addSubview:content.view];
            self.selectedContent = content;
            [self doSlideIn:^(BOOL completed) {
                [content didMoveToParentViewController:self];
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
            self.view.userInteractionEnabled = YES;
        }];
    }
}

-(void) addContentViewController:(UIViewController*) content withIndexPath:(NSIndexPath*)indexPath{
    Boolean allowContentViewControllerCaching = YES;
    if (indexPath) {
        if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(allowContentViewControllerCachingForIndexPath:)]) {
            allowContentViewControllerCaching = [self.leftMenu.slideMenuDataSource allowContentViewControllerCachingForIndexPath:indexPath];
        }
        if (allowContentViewControllerCaching) {
            [controllers setObject:content forKey:indexPath];
        }
    }
}

#pragma mark -
#pragma mark UIViewController
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    CGRect bounds = self.view.bounds;
    CGFloat menuSize = [self menuSize];
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        CGRect rightFrame = CGRectMake(bounds.size.width-menuSize, 0, menuSize, bounds.size.height);
        self.rightMenu.view.frame = rightFrame;
        self.shieldWithMenu.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    }
}
-(void) viewDidLoad{
    [super viewDidLoad];
    
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
    
    
    [self performSegueWithIdentifier:@"leftMenu" sender:self];
    if ([self.leftMenu.slideMenuDataSource respondsToSelector:@selector(hasRightMenuForIndexPath:)]) {
        [self performSegueWithIdentifier:@"rightMenu" sender:self];
    }
}
-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [controllers removeAllObjects];
}


@end
