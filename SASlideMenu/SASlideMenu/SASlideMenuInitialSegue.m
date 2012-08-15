//
//  SASlideMenuInitialSegue.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/31/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuInitialSegue.h"
#import "SASlideMenuViewController.h"
#import "SASlideMenuItemViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation SASlideMenuInitialSegue

-(void) perform{
    SASlideMenuViewController* source = self.sourceViewController;
    UINavigationController* destination = self.destinationViewController;
    
    UIGraphicsBeginImageContext(destination.view.bounds.size); 
    [destination.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    source.screenShotImageView.image = screenShotImage;    
    UIGraphicsEndImageContext();

    [source.screenShotImageView setFrame:CGRectMake(0, 0, source.view.frame.size.width, source.view.frame.size.height)];
    
   
    [UIView animateWithDuration:kStartUpAnimation delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        source.startUpView.alpha = 0.0;
    } completion:^(BOOL done){
        [source presentViewController:destination animated:NO completion:nil];
    }];
    
}

@end
