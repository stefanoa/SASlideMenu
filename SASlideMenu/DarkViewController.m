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
-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"[%@ initWithCoder:]",self);

    }
    return self;
}

-(void) tap{
    tapCount++;
    if (tapCount%2 == 0 ) {
        self.view.backgroundColor = [UIColor darkGrayColor];
    }else{
        self.view.backgroundColor = [UIColor blackColor];
    }
    NSLog(@"[%@ tap]",self);

}

-(void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tapGesture];
    NSLog(@"[%@ viewDidLoad]",self);
}

-(void) viewWillAppear:(BOOL)animated{
    NSLog(@"[%@ viewWillAppear:]",self);
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
