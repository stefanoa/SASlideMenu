//
//  ExampleMenuViewController.m
//  SASlideMenu
//
//  This is an example implementation for the SASlideMenuViewController. 
//
//  Created by Stefano Antonelli on 8/13/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ExampleStaticMenuViewController.h"
#import "MenuCell.h"
#import "DarkViewController.h"

@interface ExampleStaticMenuViewController ()

@end

@implementation ExampleStaticMenuViewController

-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        // Assign self to the slideMenuDataSource because self will implement SASlideMenuDatSource 
        self.slideMenuDataSource = self;
        self.slideMenuDelegate = self;
    }
    return self;
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        // Assign self to the slideMenuDataSource because self will implement SASlideMenuDataSource
        self.slideMenuDataSource = self;
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}


#pragma mark -
#pragma mark SASlideMenuDataSource
// The SASlideMenuDataSource is used to provide the initial segueid that represents the initial visibile view controller and to provide eventual additional configuration to the menu button

// This is the segue you want visibile when the controller is loaded the first time
-(NSString*) initialSegueId{
    return @"dark";
}

// This is used to configure the menu button. The beahviour of the button should not be modified
-(void) configureMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuicon.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
    [menuButton setAdjustsImageWhenHighlighted:NO];
    [menuButton setAdjustsImageWhenDisabled:NO];
}

-(void) configureSlideLayer:(CALayer *)layer{
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.3;
    layer.shadowOffset = CGSizeMake(-15, 0);
    layer.shadowRadius = 10;
    layer.masksToBounds = NO;
    layer.shadowPath =[UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
}

-(CGFloat) slideMenuVisibleWidth{
    return 280;
}

#pragma mark -
#pragma mark SASlideMenuDelegate

-(void) slideMenuWillSlideIn{
    NSLog(@"slideMenuWillSlideIn");
}
-(void) slideMenuDidSlideIn{
    NSLog(@"slideMenuDidSlideIn");
}
-(void) slideMenuWillSlideToSide{
    NSLog(@"slideMenuWillSlideToSide");    
}
-(void) slideMenuDidSlideToSide{
    NSLog(@"slideMenuDidSlideToSide");
    
}
-(void) slideMenuWillSlideOut{
    NSLog(@"slideMenuWillSlideOut");
    
}
-(void) slideMenuDidSlideOut{
    NSLog(@"slideMenuDidSlideOut");
}

@end
