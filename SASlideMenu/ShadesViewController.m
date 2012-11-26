//
//  LightViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 10/26/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "ShadesViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ShadesViewController ()


@end

@implementation ShadesViewController

@synthesize tableContainer;


- (void)viewDidLoad
{
    [super viewDidLoad];
    CALayer* layer = [tableContainer layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.6;
    layer.shadowOffset = CGSizeMake(-15, 0);
    layer.shadowRadius = 10;
    layer.masksToBounds = NO;
    
}

-(void) viewWillAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"light";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    
    CGFloat hue = ((double) indexPath.section)/10.0;
    CGFloat brightness = 1-((double) indexPath.row)/10.0;
    cell.backgroundColor = [UIColor colorWithHue:hue saturation:1.0 brightness:brightness alpha:1.0];
    return cell;
}


-(void) viewWillLayoutSubviews{
    CGSize frameSize = self.view.frame.size;
    CGRect tableFrame = CGRectMake(10, 10, frameSize.width-2*10, frameSize.height-2*10);
    self.tableContainer.frame = tableFrame;
    
}

@end
