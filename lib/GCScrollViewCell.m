//
//  GCScorllViewCell.m
//  GCCycleScrollViewProject
//
//  Created by 万鸿恩 on 16/3/28.
//  Copyright © 2016年 万鸿恩. All rights reserved.
//

#import "GCScrollViewCell.h"
#import "UIView+Frame.h"

@implementation GCScrollViewCell
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

/**
 *  初始化
 */
-(void)setUp{
    _imgView = [[UIImageView alloc] init];
    [self addSubview:_imgView];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.hidden = YES;
    [self addSubview:_titleLabel];
}




- (void)layoutSubviews{
    [super layoutSubviews];
    
    _imgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    CGFloat titleLabelW = self.width;
    CGFloat titleLabelH = _titleLabelHeight;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = self.height - titleLabelH;
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    _titleLabel.hidden = !_titleLabel.text;
    
}


#pragma mark -set & get
-(void)setTitle:(NSString *)title{
    _title = [[NSString alloc] init];
    _title = title;
    _titleLabel.text =  [NSString stringWithFormat:@"   %@", title];
}

-(void)setTitleLabelBgColor:(UIColor *)titleLabelBgColor{
    _titleLabelBgColor = titleLabelBgColor;
    _titleLabel.backgroundColor = titleLabelBgColor;
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont{
    _titleLabelFont = titleLabelFont;
    _titleLabel.font = titleLabelFont;
}

-(void)setTitleLabelHeight:(CGFloat)titleLabelHeight{
    _titleLabelHeight = titleLabelHeight;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}



@end
