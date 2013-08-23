//
//  GreenViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 8/23/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import "GreenViewController.h"

@interface GreenViewController ()

@end

@implementation GreenViewController

-(IBAction)tap:(id)sender{
    [self.menuController revealRightMenu];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

@end
