//
//  SASlideMenuCell.h
//  SASlideMenu
//
//  Created by Stefano Antonelli on 8/6/12.
//  Copyright (c) 2012 Stefano Antonelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* itemDescription;
@property (nonatomic, weak) IBOutlet UIImageView* disclosureImage;

@end
