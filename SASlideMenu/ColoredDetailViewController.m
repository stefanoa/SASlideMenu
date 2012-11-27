//
//  ColoredDetailViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/27/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "ColoredDetailViewController.h"

@interface ColoredDetailViewController ()

@end

@implementation ColoredDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.colorBox.backgroundColor = self.color;
    self.hue.text = [NSString stringWithFormat:@"%.0f",self.hueValue*360];
    self.brightness.text = [NSString stringWithFormat:@"%.2f",self.brightnessValue];
    self.saturation.text = [NSString stringWithFormat:@"%.2f",self.saturationValue];
}


@end
