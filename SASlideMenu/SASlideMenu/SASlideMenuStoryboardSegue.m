//
//  SASlideMenuStoryboardSegue.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/30/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuStoryboardSegue.h"
#import "SASlideMenuViewController.h"
#import "SASlideMenuItemViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation SASlideMenuStoryboardSegue


-(void) perform{
    SASlideMenuViewController* source = self.sourceViewController;
    UINavigationController* destination = self.destinationViewController;
    
    UIGraphicsBeginImageContext(destination.view.bounds.size); 
    [destination.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    if (source.segueWillSlideOut) {
        [UIView animateWithDuration:kSlideCompletelyOutInterval delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [source.screenShotImageView setFrame:CGRectMake(source.view.frame.size.width, 0, source.view.frame.size.width, source.view.frame.size.height)];
        } completion:^(BOOL done){
            source.screenShotImageView.image = screenShotImage;
            [UIView animateWithDuration:kSlideInInterval delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [source.screenShotImageView setFrame:CGRectMake(0, 0, source.view.frame.size.width, source.view.frame.size.height)];
            } completion:^(BOOL done){
                [source presentViewController:destination animated:NO completion:nil];
            }];
        }];
    }else{
        [UIView animateWithDuration:kSlideInInterval delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [source.screenShotImageView setFrame:CGRectMake(0, 0, source.view.frame.size.width, source.view.frame.size.height)];
        } completion:^(BOOL done){
            [source presentViewController:destination animated:NO completion:nil];
        }];
    }

}
@end
