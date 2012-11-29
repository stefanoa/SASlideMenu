//
//  SASlideMenuStaticViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/29/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SASlideMenuStaticViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface SASlideMenuStaticViewController (){
    UINavigationController* selectedContent;
    BOOL isFirstViewWillAppear;
}

@property (nonatomic, strong) UIView* shield;

@end

@implementation SASlideMenuStaticViewController

@synthesize slideMenuDataSource;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.menuTableVisibleWidth=kMenuTableWidth;
		
    }
    return self;
}
-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
       self.menuTableVisibleWidth=kMenuTableWidth;        
    }
    return self;
}

#pragma mark -
#pragma mark - SASlideMenuStaticViewController

-(void) slideOut:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    controller.view.frame = CGRectMake(bounds.size.width,0.0,bounds.size.width,bounds.size.height);
}

-(void) slideToSide:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    controller.view.frame = CGRectMake(self.menuTableVisibleWidth,0.0,bounds.size.width,bounds.size.height);
}

-(void) slideIn:(UINavigationController*) controller{
    CGRect bounds = self.view.bounds;
    controller.view.frame = CGRectMake(0.0,0.0,bounds.size.width,bounds.size.height);
}

-(void) completeSlideIn:(UINavigationController*) controller{
    [self.shield removeFromSuperview];
    [controller.visibleViewController.view addSubview:self.shield];
    self.shield.frame = controller.visibleViewController.view.bounds;
}

-(void) completeSlideToSide:(UINavigationController*) controller{
    [self.shield removeFromSuperview];
    [controller.view addSubview:self.shield];
    self.shield.frame = controller.view.bounds;
}

-(void) doSlideToSide{
	
	selectedContent.view.layer.shadowOffset = CGSizeMake(-1, -1);
	selectedContent.view.layer.shadowRadius = 5;
	selectedContent.view.layer.shadowOpacity = 0.5;
	selectedContent.view.layer.shadowColor = [[UIColor blackColor] CGColor];
	
	selectedContent.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:selectedContent.view.bounds].CGPath;
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
        [self completeSlideIn:selectedContent];
    }];
}


-(void) tapItem:(UIPanGestureRecognizer*)gesture{
    [self switchToContentViewController:selectedContent];
}

-(void) panItem:(UIPanGestureRecognizer*)gesture{
    UIView* panningView = gesture.view;
    CGPoint translation = [gesture translationInView:panningView];
    UIView* movingView = selectedContent.view;
    if (movingView.frame.origin.x + translation.x<0) {
        translation.x=0.0;
    }
    [movingView setCenter:CGPointMake([movingView center].x + translation.x, [movingView center].y)];
    [gesture setTranslation:CGPointZero inView:[panningView superview]];
    if ([gesture state] == UIGestureRecognizerStateEnded){
        CGFloat pcenterx = movingView.center.x;
        CGRect bounds = self.view.bounds;
        CGSize size = bounds.size;
        
        if (pcenterx > size.width ) {
            [self doSlideToSide];
        }else{
            [self doSlideIn:nil];
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
    CALayer* layer = [content.view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.3;
    layer.shadowOffset = CGSizeMake(-15, 0);
    layer.shadowRadius = 10;
    layer.masksToBounds = NO;
    layer.shadowPath =[UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
}

-(void) prepareForSwitchToContentViewController:(UIViewController*) content{}

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
    self.shield = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panItem:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [self.shield addGestureRecognizer:panGesture];
    
    self.tableView.delegate = self;
}
@end
