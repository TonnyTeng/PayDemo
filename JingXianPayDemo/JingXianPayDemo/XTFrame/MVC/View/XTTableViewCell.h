//
//  XTTableViewCell.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTTableViewCell : UITableViewCell

@property (nonatomic, strong) id object;
- (void)removeAllContentView;
- (void)selectedTextField;

@end
