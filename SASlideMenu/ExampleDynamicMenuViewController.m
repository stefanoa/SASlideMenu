//
//  ExampleDynamicMenuViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/20/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "ExampleDynamicMenuViewController.h"
#import "ColoredViewController.h"
#import "GreenViewController.h"
@interface ExampleDynamicMenuViewController ()<SASlideMenuDataSource,SASlideMenuDelegate, UITableViewDataSource>

@property (nonatomic) CGFloat selectedHue;
@property (nonatomic) CGFloat selectedBrightness;

@end

@implementation ExampleDynamicMenuViewController

@synthesize selectedHue;
@synthesize selectedBrightness;

-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.selectedBrightness = 0.3;
        self.selectedHue = 0.0;        
    }
    return self;
}

-(void)tap:(id)sender{
    
}

-(void) viewDidLoad{
    [super viewDidLoad];
}
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

#pragma mark -
#pragma mark SASlideMenuDataSource

-(void) prepareForSwitchToContentViewController:(UINavigationController *)content{
    UIViewController* controller = [content.viewControllers objectAtIndex:0];
    if ([controller isKindOfClass:[ColoredViewController class]]) {
        ColoredViewController* coloredViewController = (ColoredViewController*) controller;
        [coloredViewController setBackgroundHue:selectedHue brightness:selectedBrightness];
    }else if ([controller isKindOfClass:[GreenViewController class]]) {
        GreenViewController* greenController = (GreenViewController*) controller;
        greenController.menuController = self;
    }
}

// It configure the menu button. The beahviour of the button should not be modified
-(void) configureMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuicon"] forState:UIControlStateNormal];
}

// It configure the right menu button. The beahviour of the button should not be modified
-(void) configureRightMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuiconright"] forState:UIControlStateNormal];
}

// This is the segue you want visibile when the controller is loaded the first time
-(NSIndexPath*) selectedIndexPath{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

// It maps each indexPath to the segueId to be used. The segue is performed only the first time the controller needs to loaded, subsequent switch to the content controller will use the already loaded controller

-(NSString*) segueIdForIndexPath:(NSIndexPath *)indexPath{
    NSString* result;
    switch (indexPath.section) {
        case 0:
            result = @"red";
            break;
        case 1:
            result = @"green";
            break;
        default:
            result = @"blue";
            break;
    }
    return result;
}

-(Boolean) disableContentViewControllerCachingForIndexPath:(NSIndexPath *)indexPath{
       return YES;
}

-(Boolean) hasRightMenuForIndexPath:(NSIndexPath *)indexPath{
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
    return 260;
}

-(CGFloat) rightMenuVisibleWidth{
    return 260;
}

//restricts pan gesture interation to 50px on the left and right of the view.
-(Boolean) shouldRespondToGesture:(UIGestureRecognizer*) gesture forIndexPath:(NSIndexPath*)indexPath {
    CGPoint touchPosition = [gesture locationInView:self.view];
    return (touchPosition.x < 50.0 || touchPosition.x > self.view.bounds.size.width - 50.0f);
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

-(void) slideMenuWillSlideIn:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuWillSlideIn");
}
-(void) slideMenuDidSlideIn:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuDidSlideIn");
}
-(void) slideMenuWillSlideToSide:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuWillSlideToSide");
}
-(void) slideMenuDidSlideToSide:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuDidSlideToSide");    
}
-(void) slideMenuWillSlideOut:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuWillSlideOut");
}
-(void) slideMenuDidSlideOut:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuDidSlideOut");
}
-(void) slideMenuWillSlideToLeft:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuWillSlideToLeft");    
}
-(void) slideMenuDidSlideToLeft:(UINavigationController *)selectedContent{
    NSLog(@"slideMenuDidSlideToLeft");
}
 
@end
