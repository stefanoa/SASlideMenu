//
//  ExampleiPadViewController.m
//  SASlideMenuiPad
//
//  Created by Stefano Antonelli on 3/13/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "ExampleiPadViewController.h"
#import "ColoredViewController.h"
#import "SASlideMenuRootViewController.h"

@interface ExampleiPadViewController ()
@property (nonatomic) CGFloat selectedHue;
@property (nonatomic) CGFloat selectedBrightness;

@end

@implementation ExampleiPadViewController

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}
-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.selectedHue = 0.0;
        self.selectedBrightness = 1.0;
    }
    return self;
}

#pragma mark -
#pragma mark SASlideMenuDataSource

-(void) prepareForSwitchToContentViewController:(UINavigationController *)content{
    UIViewController* controller = [content.viewControllers objectAtIndex:0];
    if ([controller isKindOfClass:[ColoredViewController class]]) {
        ColoredViewController* coloredViewController = (ColoredViewController*) controller;
        [coloredViewController setBackgroundHue:self.selectedHue brightness:self.selectedBrightness];
    }
}

-(void) configureMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuicon"] forState:UIControlStateNormal];
}

-(NSIndexPath*) selectedIndexPath{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

-(NSString*) segueIdForIndexPath:(NSIndexPath *)indexPath{
    return @"colored";
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
    return 10;
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat brightness = 1-((double) indexPath.row)/11;
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
    return 600;
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat brightness = 1-((double) indexPath.row)/11;
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
