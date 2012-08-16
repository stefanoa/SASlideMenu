//
//  SASlideMenuButton.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 8/16/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SASlideMenuButtonDelegate

-(void) doSlideOut;

@end

@interface SASlideMenuButton : UIButton

@property (nonatomic, strong) NSObject<SASlideMenuButtonDelegate>* delegate;

@end
