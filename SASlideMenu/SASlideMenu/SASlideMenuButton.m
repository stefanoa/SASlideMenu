//
//  SASlideMenuButton.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 8/16/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "SASlideMenuButton.h"

@implementation SASlideMenuButton

@synthesize delegate;

-(void) slideOut{
    self.highlighted = NO;
    [delegate doSlideOut];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"menuicon.png"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
        [self setAdjustsImageWhenHighlighted:NO];
        [self setAdjustsImageWhenDisabled:NO];
        [self addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}


@end
