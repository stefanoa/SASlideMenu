//
//  SASlideMenuDataSource.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 7/30/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SASlideMenuDataSource <NSObject>

-(NSInteger) numberOfItems;

-(NSString*) initialSegueId;
-(NSString*) segueIdForIndex:(NSInteger) index;
-(NSString*) itemNameForIndex:(NSInteger) index;

@end
