//
//  ExampleDynamicMenuViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/20/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "ExampleDynamicMenuViewController.h"
#import "ColoredViewController.h"

@interface ExampleDynamicMenuViewController ()

@property (nonatomic) CGFloat selectedHue;
@property (nonatomic) CGFloat selectedBrightness;

@end

@implementation ExampleDynamicMenuViewController

@synthesize selectedHue;
@synthesize selectedBrightness;

-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        // Assign self to the slideMenuDataSource because self will implement SASlideMenuDatSource
        self.slideMenuDataSource = self;
        self.slideMenuDelegate = self;
        self.selectedBrightness = 0.3;
        self.selectedHue = 0.0;
        
    }
    return self;
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        // Assign self to the slideMenuDataSource because self will implement SASlideMenuDataSource
        self.slideMenuDataSource = self;
        self.selectedBrightness = 0.3;
        self.selectedHue = 0.0;
    }
    return self;
}

-(void)tap:(id)sender{
    
}
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

-(void) prepareForSwitchToContentViewController:(UIViewController *)content{
    UINavigationController* navigationController = (UINavigationController*)content;
    ColoredViewController* coloredViewController = (ColoredViewController*) navigationController.topViewController;
    
    [coloredViewController setBackgroundHue:selectedHue brightness:selectedBrightness];
}
#pragma mark -
#pragma mark SASlideMenuDataSource

// The SASlideMenuDataSource provides the initial segueid that represents the initial visibile view controller, the eventual additional configuration to the menu button and the mapping for each indexPath to the segues for the content controllers


// This is the segue you want visibile when the controller is loaded the first time
-(NSString*) initialSegueId{
    return @"colored";
}


// It configure the menu button. The beahviour of the button should not be modified
-(void) configureMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuicon.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
    [menuButton setAdjustsImageWhenHighlighted:NO];
    [menuButton setAdjustsImageWhenDisabled:NO];
}

-(void) configureRightMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuright.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
    [menuButton setAdjustsImageWhenHighlighted:NO];
    [menuButton setAdjustsImageWhenDisabled:NO];
}
// It maps each indexPath to the segueId to be used. The segue is performed only the first time the controller needs to loaded, subsequent switch to the content controller will use the already loaded controller

-(NSString*) segueIdForIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 0) {
        return @"coloredNoRightMenu";
    }
    return @"colored";
}
-(Boolean) slideOutThenIn{
    return NO;
}
-(Boolean) allowContentViewControllerCachingForIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        return NO;
    }
    return YES;
}

-(Boolean) hasRightMenuForSegueId:(NSString *)segueId{
    if ([segueId isEqualToString:@"coloredNoRightMenu"]) {
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Red";
    }else if (section == 1){
        return @"Green";
    }else {
        return @"Blue";
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat brightness = 1-((double) indexPath.row)/5;
    NSInteger section = indexPath.section;
    CGFloat hue=0;
    if (section == 0) {
        hue = 0.0;
    }else if (section==1){
        hue = 0.33;
    }else if (section==2){
        hue = 0.66;
    }
    cell.backgroundColor = [UIColor colorWithHue:hue saturation:1.0 brightness:brightness alpha:1.0];
    
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"item"];
    return cell;
}

-(CGFloat) leftMenuVisibleWidth{
    return 280;
}

-(CGFloat) rightMenuVisibleWidth{
    return 300;
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat brightness = 1-((double) indexPath.row)/5;
    NSInteger section = indexPath.section;
    CGFloat hue=0;
    if (section == 0) {
        hue = 0.0;
    }else if (section==1){
        hue = 0.33;
    }else if (section==2){
        hue = 0.66;
    }
    self.selectedHue = hue;
    self.selectedBrightness = brightness;
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
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
-(void) slideMenuWillSlideToLeft{
    NSLog(@"slideMenuWillSlideToLeft");    
}
-(void) slideMenuDidSlideToLeft{
    NSLog(@"slideMenuDidSlideToLeft");
}
@end
