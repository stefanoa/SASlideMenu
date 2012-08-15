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
#import "SASlideMenuItemViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface SASlideMenuViewController ()

@end

@implementation SASlideMenuViewController

@synthesize slideMenuTableView;
@synthesize startUpView;
@synthesize screenShotImageView;

@synthesize segueWillSlideOut;
@synthesize activeItemId;
@synthesize tapGesture;
@synthesize panGesture;
@synthesize slideMenuDataSource;

#pragma mark -
#pragma mark - SASlideMenuViewController
-(void) tapItem:(UIPanGestureRecognizer*)gesture{
    [self performSegueWithIdentifier:self.activeItemId sender:self];
    
}

-(void) panItem:(UIPanGestureRecognizer*)gesture{
    UIView* panningView = gesture.view;
    CGPoint translation = [gesture translationInView:panningView];
    
    [panningView setCenter:CGPointMake([panningView center].x + translation.x, [panningView center].y)];
    [gesture setTranslation:CGPointZero inView:[panningView superview]];
    if ([gesture state] == UIGestureRecognizerStateEnded){
        CGFloat pcenterx =panningView.center.x;
        CGSize size = self.view.bounds.size;
        
        if (pcenterx > size.width ) {
            [UIView animateWithDuration:kSlideOutInterval delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [panningView setCenter:CGPointMake(size.width+panningView.bounds.size.width/2-kVisiblePortion, [panningView center].y)];
            } completion:^(BOOL completed){}];

            
        }else{
            self.segueWillSlideOut = NO;
            [self performSegueWithIdentifier:self.activeItemId sender:self];
        }
	}

}

#pragma mark -
#pragma mark - UIViewController
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (isFirstViewWillAppear) {
        [self performSegueWithIdentifier:@"initial" sender:self];
        self.activeItemId = [slideMenuDataSource initialSegueId];
        isFirstViewWillAppear = NO;
    }else {
        [startUpView removeFromSuperview];
    }

}

-(void) viewDidLoad{
    [super viewDidLoad];

    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem:)];
    [screenShotImageView addGestureRecognizer:tapGesture];
    
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panItem:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [screenShotImageView addGestureRecognizer:panGesture];

    
    isFirstViewWillAppear = YES;

    CALayer* layer = [self.screenShotImageView layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.3;
    layer.shadowOffset = CGSizeMake(-15, 0);
    layer.shadowRadius = 10;
    layer.masksToBounds = NO;
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
    self.segueWillSlideOut = YES;
    [self performSegueWithIdentifier:self.activeItemId sender:self];

}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UINavigationController* navigationViewController = segue.destinationViewController;
    SASlideMenuItemViewController* item = (SASlideMenuItemViewController*)navigationViewController;
    item.slideMenuDelegate = self;
}

#pragma mark -
#pragma mark SlideoutViewControllerDelegate

-(void) activateSlideMenuFromItem:(SASlideMenuItemViewController*) slideMenuItemViewController{
    UIView* targetView = slideMenuItemViewController.view;
    CGSize viewSize = targetView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(viewSize, NO, 0.0);
    [targetView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage* screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [screenShotImageView setImage:screenShotImage];
    [screenShotImageView setFrame:frame];
    
    [UIView animateWithDuration:kSlideOutInterval delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [screenShotImageView setFrame:CGRectMake(self.view.frame.size.width-kVisiblePortion, 0, self.view.frame.size.width, self.view.frame.size.height)];
    } completion:^(BOOL completed){
    
        NSIndexPath* selectedRow = [self.slideMenuTableView indexPathForSelectedRow];
        [self.slideMenuTableView deselectRowAtIndexPath:selectedRow animated:YES];
        
    }];

    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
