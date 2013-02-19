//
//  LightViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 2/18/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "LightViewController.h"

@interface LightViewController ()

@end

@implementation LightViewController

-(IBAction)tap:(id)sender{
    [self.menuViewController selectContentAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] scrollPosition:UITableViewScrollPositionTop];
}
@end
