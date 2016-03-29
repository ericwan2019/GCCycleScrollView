//
//  UIView+Frame.h
//  Horus
//
//  Created by 万鸿恩 on 15/11/5.
//  Copyright © 2015年 Cybersys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
// 分类不能添加成员属性
// @property如果在分类里面，只会自动生成get,set方法的声明，不会生成成员属性，和方法的实现
/**
 *  顶部原点y
 */
@property (assign, nonatomic) CGFloat    top;
/**
 *  底部y
 */
@property (assign, nonatomic) CGFloat    bottom;
/**
 *  左侧x
 */
@property (assign, nonatomic) CGFloat    left;
/**
 *  右侧x
 */
@property (assign, nonatomic) CGFloat    right;

/**
 * 原点 x
 */
@property (assign, nonatomic) CGFloat    x;
/**
 *  原点 y
 */
@property (assign, nonatomic) CGFloat    y;
/**
 *  原点坐标（x,y）
 */
@property (assign, nonatomic) CGPoint    origin;
/**
 *  中心点x
 */
@property (assign, nonatomic) CGFloat    centerX;
/**
 *  中心点 y
 */
@property (assign, nonatomic) CGFloat    centerY;

/**
 *  宽
 */
@property (assign, nonatomic) CGFloat    width;
/**
 *  高
 */
@property (assign, nonatomic) CGFloat    height;
/**
 *  size尺寸
 */
@property (assign, nonatomic) CGSize    size;
@end
