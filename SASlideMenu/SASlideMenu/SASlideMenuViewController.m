//
//  SASlideMenuViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/29/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SASlideMenuCell.h"
#import "SASlideMenuViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface SASlideMenuViewController (){
    NSMutableDictionary* controllers;
    UIViewController* selectedContent;
    BOOL isFirstViewWillAppear;

}

@property (nonatomic, strong) UIView* shield;

@end

@implementation SASlideMenuViewController

@synthesize slideMenuTableView;
@synthesize startUpView;
@synthesize activeItemId;
@synthesize slideMenuDataSource;

#pragma mark -
#pragma mark - SASlideMenuViewController

-(void) tapItem:(UIPanGestureRecognizer*)gesture{
    [self switchToContentViewController:selectedContent];
}

-(void) panItem:(UIPanGestureRecognizer*)gesture{
    UIView* panningView = gesture.view;
    CGPoint translation = [gesture translationInView:panningView];
    UIView* movingView = selectedContent.view;
    
    [movingView setCenter:CGPointMake([movingView center].x + translation.x, [movingView center].y)];
    [gesture setTranslation:CGPointZero inView:[panningView superview]];
    if ([gesture state] == UIGestureRecognizerStateEnded){
        CGFloat pcenterx = movingView.center.x;
        CGSize size = self.view.bounds.size;
        
        if (pcenterx > size.width ) {
            [UIView animateWithDuration:kSlideOutInterval delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [movingView setCenter:CGPointMake(size.width+movingView.bounds.size.width/2-kVisiblePortion, [movingView center].y)];
            } completion:^(BOOL completed){}];

            
        }else{
            [self switchToContentViewController:selectedContent];
        }
	}
}

#pragma mark -
#pragma mark - UIViewController
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (isFirstViewWillAppear) {
        self.activeItemId = [slideMenuDataSource segueIdForIndex:0];
        [self performSegueWithIdentifier:self.activeItemId sender:self];
        
        isFirstViewWillAppear = NO;
    }else {
        [startUpView removeFromSuperview];
    }

}

-(void) viewDidLoad{
    [super viewDidLoad];


    isFirstViewWillAppear = YES;
    controllers = [[NSMutableDictionary alloc] init];
    self.shield = [[UIView alloc] initWithFrame:CGRectZero];

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem:)];
    [self.shield addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panItem:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [self.shield addGestureRecognizer:panGesture];
    
}

-(void) switchToContentViewController:(UIViewController*) content{
    
    if (content != selectedContent) {
        [self addChildViewController:content];
        CGRect bounds = self.view.bounds;
        content.view.frame = CGRectMake(bounds.size.width,0,0,bounds.size.height);
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
            selectedContent.view.frame = CGRectMake(bounds.size.width,0,bounds.size.width,bounds.size.height);
            } completion:
         ^(BOOL completed) {
             [selectedContent.view removeFromSuperview];
             [selectedContent removeFromParentViewController];
             [self.view addSubview:content.view];
             [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
                 content.view.frame = CGRectMake(0,0,bounds.size.width,bounds.size.height);
                 
             } completion:^(BOOL completed){
                 selectedContent = content;
                 [self.shield removeFromSuperview];
             }];
         }];
        
        
    }else{
        CGRect bounds = self.view.bounds;
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
            selectedContent.view.frame = CGRectMake(0,0,bounds.size.width,bounds.size.height);
            
        } completion:^(BOOL completed) {
            [self.shield removeFromSuperview];
        }];
        
    }
    
}


-(void) addContentViewController:(UIViewController*) content withIdentifier:(NSString*)identifier{
    CALayer* layer = [content.view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.3;
    layer.shadowOffset = CGSizeMake(-15, 0);
    layer.shadowRadius = 10;
    layer.masksToBounds = NO;

    [controllers setObject:content forKey:identifier];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView {
	return 1;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.slideMenuDataSource numberOfItems];
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
	SASlideMenuCell* cell = (SASlideMenuCell*)[tableView dequeueReusableCellWithIdentifier:@"SlideMenuCell"];
	
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"row.png"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rowselected.png"]];
    
    NSString* itemName = [self.slideMenuDataSource itemNameForIndex:indexPath.row];
    cell.itemDescription.text = itemName;
	return cell;
}

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    self.activeItemId= [self.slideMenuDataSource segueIdForIndex:indexPath.row];
    
    UIViewController* content = [controllers objectForKey:self.activeItemId];
    if (!content) {
        [self performSegueWithIdentifier:self.activeItemId sender:self];
    }else{
        [self switchToContentViewController:content];
    }
}


#pragma mark -
#pragma mark SASlideMenuButtonDelegate

-(void) doSlideOut{
    CGRect bounds = self.view.bounds;
    self.shield.frame = bounds;
    [selectedContent.view addSubview:self.shield];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
        selectedContent.view.frame = CGRectMake(bounds.size.width-kVisiblePortion,0,bounds.size.width,bounds.size.height);
        
    } completion:nil];

}


@end
