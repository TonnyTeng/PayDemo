//
//  XTTableViewCell.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "XTTableViewCell.h"

@implementation XTTableViewCell

- (void)removeAllContentView
{
    for (UIView *view in self.contentView.subviews)
    {
        [view removeFromSuperview];
    }
}

- (void)selectedTextField
{
    for (UIView *view in self.contentView.subviews)
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            UITextField *textField = (UITextField *)view;
            [textField becomeFirstResponder];
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
