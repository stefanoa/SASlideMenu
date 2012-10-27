//
//  DarkViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 8/16/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "DarkViewController.h"

@interface DarkViewController (){
    NSInteger tapCount;
}

@end

@implementation DarkViewController

@synthesize menuViewController;

-(void) tap{
    tapCount++;
    if (tapCount%2 == 0 ) {
        self.view.backgroundColor = [UIColor darkGrayColor];
    }else{
        self.view.backgroundColor = [UIColor blackColor];
    }
    [menuViewController performSegueWithIdentifier:@"light" sender:self];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
