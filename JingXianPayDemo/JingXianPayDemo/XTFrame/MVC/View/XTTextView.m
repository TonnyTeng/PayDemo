//
//  XTTextView.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "XTTextView.h"

@interface XTTextView()<UITextViewDelegate>
{
    UILabel *PlaceholderLabel;
}

@end
@implementation XTTextView

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}


- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
    
    float left=5,top=6,hegiht=30;
    
    self.placeholderColor = [UIColor lightGrayColor];
    PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                               , CGRectGetWidth(self.frame)-2*left, hegiht)];
    PlaceholderLabel.lineBreakMode = NSLineBreakByCharWrapping;
    PlaceholderLabel.numberOfLines = 0;
    PlaceholderLabel.font = self.placeholderFont?self.placeholderFont:self.font;
    [self addSubview:PlaceholderLabel];
    PlaceholderLabel.text = self.placeholder;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (!isNil(text))
    {
        PlaceholderLabel.hidden=YES;
    }
}

-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    else
        PlaceholderLabel.text=placeholder;
    _placeholder=placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    PlaceholderLabel.textColor = self.placeholderColor;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    PlaceholderLabel.font = _placeholderFont;
}

-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        PlaceholderLabel.hidden=YES;
    }
    else{
        PlaceholderLabel.hidden=NO;
    }
    
}


@end
