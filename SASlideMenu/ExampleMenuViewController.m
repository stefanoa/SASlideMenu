//
//  ExampleMenuViewController.m
//  SASlideMenu
//
//  Created by Stefano Antonelli on 8/13/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import "ExampleMenuViewController.h"

@interface ExampleMenuViewController ()

@end

@implementation ExampleMenuViewController

-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.slideMenuDataSource = self;
        
    }
    return self;
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.slideMenuDataSource = self;
    }
    return self;
}

-(NSInteger) numberOfItems{
    return 2;
}

-(NSString*) initialSegueId{
    return @"dark";
}

-(NSString*) segueIdForIndex:(NSInteger) index{
    if (index ==0 ) {
        return @"dark";
    }else {
        return @"light";
    }
}
-(NSString*) itemNameForIndex:(NSInteger) index{
    if (index ==0 ) {
        return @"Dark";
    }else {
        return @"Light";
    }
    
}


@end
