//
//  SASlideMenuViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 1/17/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuViewController.h"
#import "SASlideMenuRootViewController.h"
@interface SASlideMenuViewController ()
<SASlideMenuDataSource, SASlideMenuDelegate>
-(void)setup;
@end

@implementation SASlideMenuViewController

#pragma mark -
#pragma mark Init
-(void)setup; {
  if(self.slideMenuDataSource == nil)
    self.slideMenuDataSource = self;
  if(self.slideMenuDelegate == nil)
    self.slideMenuDelegate = self;

}

-(id)initWithCoder:(NSCoder *)aDecoder; {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self setup];
  }
  return self;
}

-(id)init; {
  self = [super self];
  if (self) {
    [self setup];
  }
  return self;
}

#pragma mark -
#pragma mark SASlideMenuViewController

-(void)selectContentAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.slideMenuDataSource respondsToSelector:@selector(segueIdForIndexPath:)]) {
        [self didSelectRowAtIndexPath:indexPath];
     
        Boolean disableContentViewControllerCaching= NO;
        if ([self.slideMenuDataSource respondsToSelector:@selector(disableContentViewControllerCachingForIndexPath::)]) {
            disableContentViewControllerCaching = [self.slideMenuDataSource disableContentViewControllerCachingForIndexPath:indexPath];
        }
        UINavigationController* controller = [self.rootController controllerForIndexPath:indexPath];
        if (controller) {
            [self.rootController switchToContentViewController:controller];
            return;
        }
        NSString* segueId = [self.slideMenuDataSource segueIdForIndexPath:indexPath];
        [self performSegueWithIdentifier:segueId sender:self];
    }
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark UITableViewDelegate

-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.slideMenuDataSource respondsToSelector:@selector(segueIdForIndexPath:)]) {
        UINavigationController* controller = [self.rootController controllerForIndexPath:indexPath];
        if (controller) {
            [self.rootController switchToContentViewController:controller];
            return;
        }
        NSString* segueId = [self.slideMenuDataSource segueIdForIndexPath:indexPath];
        [self performSegueWithIdentifier:segueId sender:self];        
    }
}

@end
