//
//  ColoredDetailViewController.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 11/27/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColoredDetailViewController : UITableViewController
@property(nonatomic,strong) IBOutlet UIView* colorBox;
@property(nonatomic,strong) IBOutlet UILabel* hue;
@property(nonatomic,strong) IBOutlet UILabel* brightness;
@property(nonatomic,strong) IBOutlet UILabel* saturation;

@property(nonatomic,strong) UIColor* color;
@property(nonatomic) CGFloat hueValue;
@property(nonatomic) CGFloat brightnessValue;
@property(nonatomic) CGFloat saturationValue;

@end
