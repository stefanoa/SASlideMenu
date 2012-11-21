//
//  ColoredViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/21/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "ColoredViewController.h"

@interface ColoredViewController ()

@end

@implementation ColoredViewController

-(void) setBackgroundHue:(CGFloat) hue brightness:(CGFloat) brightness{
    self.view.backgroundColor = [UIColor colorWithHue:hue saturation:1.0 brightness:brightness alpha:1.0];
}

@end
