//
//  DarkViewController.h
//  SASlideMenu
//
//  This is a very simple UIViewController created for test
//
//  Created by Stefano Antonelli on 8/16/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DarkViewController : UIViewController

@property (nonatomic,strong) IBOutlet UISlider *darknessSlider;

-(IBAction) changeDarkness:(id) sender;

@end
