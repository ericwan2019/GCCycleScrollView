//
//  GCScorllViewCell.h
//  GCCycleScrollViewProject
//
//  Created by 万鸿恩 on 16/3/28.
//  Copyright © 2016年 万鸿恩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCScrollViewCell : UIView

/**
 *  标题 label
 */
@property (nonatomic,strong) UILabel *titleLabel;
/**
 *  标题字符
 */
@property (copy, nonatomic) NSString *title;
/**
 *  标题字体颜色
 */
@property (nonatomic, strong) UIColor *titleLabelTextColor;
/**
 *  标题字体大小
 */
@property (nonatomic, strong) UIFont *titleLabelFont;
/**
 *  标题背景色
 */
@property (nonatomic, strong) UIColor *titleLabelBgColor;
/**
 *  标题字体高度
 */
@property (nonatomic, assign) CGFloat titleLabelHeight;


/**
 *  图片
 */
@property (strong, nonatomic) UIImageView *imgView;


@end
