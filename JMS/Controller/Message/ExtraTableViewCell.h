//
//  ExtraTableViewCell.h
//  JSM
//
//  Created by 黄沐 on 2016/10/22.
//  Copyright © 2016年 Jiumeisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtraTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *innerView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;
@end
