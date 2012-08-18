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
-(void) tap{
    tapCount++;
    if (tapCount%2 == 0 ) {
        self.view.backgroundColor = [UIColor darkGrayColor];
    }else{
        self.view.backgroundColor = [UIColor blackColor];
        
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tapGesture];
	// Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    tapCount++;
    if (tapCount%2 == 0 ) {
        self.view.backgroundColor = [UIColor darkGrayColor];
    }else{
        self.view.backgroundColor = [UIColor blackColor];
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
