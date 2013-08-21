//
//  FirstViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 2/22/13.
//  Copyright (c) 2013 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITapGestureRecognizer* tapGesture;

-(IBAction)tap:(id)sender;

@end
