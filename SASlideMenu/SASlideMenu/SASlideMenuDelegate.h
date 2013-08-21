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

-(void)slideMenuWillSlideToSide:(UINavigationController*) selectedContent;
-(void)slideMenuDidSlideToSide:(UINavigationController*) selectedContent;

-(void)slideMenuWillSlideIn:(UINavigationController*) selectedContent;
-(void)slideMenuDidSlideIn:(UINavigationController*) selectedContent;

-(void)slideMenuWillSlideOut:(UINavigationController*) selectedContent;
-(void)slideMenuDidSlideOut:(UINavigationController*) selectedContent;

-(void) slideMenuWillSlideToLeft:(UINavigationController*) selectedContent;
-(void) slideMenuDidSlideToLeft:(UINavigationController*) selectedContent;

@end
