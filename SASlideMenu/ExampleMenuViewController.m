//
//  ExampleMenuViewController.m
//  SASlideMenu
//
//  This is an example implementation for the SASlideMenuViewController. 
//
//  Created by Stefano Antonelli on 8/13/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "ExampleMenuViewController.h"
#import "MenuCell.h"
#import "DarkViewController.h"

@interface ExampleMenuViewController ()

@end

@implementation ExampleMenuViewController

-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        // Assign self to the slideMenuDataSource beacase self will implement SASlideMenuDatSource 
        self.slideMenuDataSource = self;
        
    }
    return self;
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        // Assign self to the slideMenuDataSource beacase self will implement SASlideMenuDatSource
        self.slideMenuDataSource = self;
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"dark"]) {
        UINavigationController* navigationController = segue.destinationViewController;
        DarkViewController* darkController = (DarkViewController*)navigationController.topViewController;
        darkController.menuViewController = self;
    }
}

#pragma mark -
#pragma mark SASlideMenuDataSource
// The SASlideMenuDataSource is used to provide the initial segueid that represents the initial visibile view controller and possible additional configuration to the menu button


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

@end
