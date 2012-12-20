//
//  SASlideMenuDelegate.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 12/19/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SASlideMenuDelegate <NSObject>

@optional

-(void)slideMenuWillSlideToSide;
-(void)slideMenuDidSlideToSide;

-(void)slideMenuWillSlideIn;
-(void)slideMenuDidSlideIn;

-(void)slideMenuWillSlideOut;
-(void)slideMenuDidSlideOut;

-(void) slideMenuWillSlideToLeft;
-(void) slideMenuDidSlideToLeft;

@end
