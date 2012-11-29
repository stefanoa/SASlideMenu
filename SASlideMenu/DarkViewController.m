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

@synthesize darknessSlider;
-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"[%@ initWithCoder:]",self);

        
    }
    return self;
}

-(IBAction) changeDarkness:(id) sender{
    CGFloat darkness = darknessSlider.value;
    self.view.backgroundColor = [UIColor colorWithWhite:darkness alpha:1.0];    
}

-(void) tap{
    tapCount++;
    if (tapCount%2 == 0 ) {
        self.view.backgroundColor = [UIColor darkGrayColor];
        CGFloat white,alpha;
        [[UIColor darkGrayColor] getWhite:&white alpha:&alpha];
        [darknessSlider setValue:white animated:YES];
    }else{
        [darknessSlider setValue:0.0 animated:YES];
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
