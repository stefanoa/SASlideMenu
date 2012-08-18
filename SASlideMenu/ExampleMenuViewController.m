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
@interface ExampleMenuViewController ()

@end

@implementation ExampleMenuViewController

-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        // Assign self to the slideMenuDataSource beacase self will implement SASlideMeneDatSource 
        self.slideMenuDataSource = self;
        
    }
    return self;
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        // Assign self to the slideMenuDataSource beacase self will implement SASlideMeneDatSource
        self.slideMenuDataSource = self;
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource
// Implement it has needed by your Menu table

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView {
	return 1;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

// Implement it has needed for your cells. Keep in mind, when placing the disclosure indicators, that the current selected UIViewController overlap the menu table by  kVisiblePortion = 40 pixels

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
// The SASlideMenuDataSource is used to map the cells to the corresponding segues in the Storyboard and to provide a additional configuration to the menu button


// This is the segue you want active when the controller is loaded the first time
-(NSString*) initialSegueId{
    return @"dark";
}

// This is needed to map each row in the menu table to a segue in the Storyboard, a missing map or wrong indentifier will result in an exception
-(NSString*) segueIdForIndexPath:(NSIndexPath*) indexPath{
    if (indexPath.row ==0 ) {
        return @"dark";
    }else {
        return @"light";
    }
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
