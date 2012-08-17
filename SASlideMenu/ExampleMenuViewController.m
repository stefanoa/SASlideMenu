//
//  ExampleMenuViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 8/13/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "ExampleMenuViewController.h"
#import "MenuCell.h"
@interface ExampleMenuViewController ()

@end

@implementation ExampleMenuViewController

-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.slideMenuDataSource = self;
        
    }
    return self;
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.slideMenuDataSource = self;
    }
    return self;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView {
	return 1;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
	MenuCell* cell = (MenuCell*)[tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
	
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"row.png"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rowselected.png"]];

    NSString* itemName;
    if (indexPath.row == 0) {
        itemName = @"Dark";
    }else{
        itemName =  @"Light";
    }
    
    cell.itemDescription.text = itemName;
	return cell;
}

#pragma mark -
#pragma mark SASlideMenuDataSource
-(NSString*) initialSegueId{
    return @"dark";
}

-(NSString*) segueIdForIndexPath:(NSIndexPath*) indexPath{
    if (indexPath.row ==0 ) {
        return @"dark";
    }else {
        return @"light";
    }
}

-(void) configureMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuicon.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
    [menuButton setAdjustsImageWhenHighlighted:NO];
    [menuButton setAdjustsImageWhenDisabled:NO];
}

@end
