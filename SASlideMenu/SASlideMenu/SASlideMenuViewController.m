//
//  SASlideMenuViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 1/17/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuViewController.h"

@interface SASlideMenuViewController ()

@end

@implementation SASlideMenuViewController

#pragma mark -
#pragma mark UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.slideMenuDataSource respondsToSelector:@selector(segueIdForIndexPath:)]) {
        NSString* segueId = [self.slideMenuDataSource segueIdForIndexPath:indexPath];
        [self performSegueWithIdentifier:segueId sender:self];        
    }
}

@end
