//
//  ColoredViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/21/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "ColoredViewController.h"
#import "ColoredDetailViewController.h"

@interface ColoredViewController ()

@end

@implementation ColoredViewController
-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ColoredDetailViewController* detailViewConroller = segue.destinationViewController;
    UIColor* backgroundColor = self.view.backgroundColor;
    CGFloat hue, brightness, saturation,alpha;
    [backgroundColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    detailViewConroller.hueValue = hue;
    detailViewConroller.brightnessValue = brightness;
    detailViewConroller.saturationValue = saturation;
    detailViewConroller.color = backgroundColor;

}
-(void) tap{
    [self performSegueWithIdentifier:@"detail" sender:self];
    
}

-(void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void) setBackgroundHue:(CGFloat) hue brightness:(CGFloat) brightness{
    self.view.backgroundColor = [UIColor colorWithHue:hue saturation:1.0 brightness:brightness alpha:1.0];
}

@end
