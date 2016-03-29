//
//  GCCycleScrollView.h
//  GCCycleScrollViewProject
//
//  Created by 万鸿恩 on 16/3/28.
//  Copyright © 2016年 万鸿恩. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,GCCycleScrollPageControlAliment){
    /**
     *  page control 位于中间，默认在中间
     */
    GCCycleScrollPageControlAlimentCenter = 0,
    
    /**
     *  page control 位于右侧
     */
    GCCycleScrollPageControlAlimentRight = 1,
    
    /**
     *  page control 位于左侧
     */
    GCCycleScrollPageControlAlimentLeft = 2
};


@class GCCycleScrollView;

@protocol GCCycleScrollViewDelegate <NSObject>
/**
 *  滚动图片点击事件，点击来第row张图片
 *
 *  @param cycleScrollView 创建的scrollview
 *  @param row             第row行
 */
- (void)cycleScrollView:(GCCycleScrollView*)cycleScrollView didSelectItemAtRow:(NSInteger)row;

@end

@interface GCCycleScrollView : UIView

/**
 *  代理
 */
@property (nonatomic,weak) id <GCCycleScrollViewDelegate>delegate;
/**
 *  本地图片数组,每一个element必须是uiimage
 */
@property (nonatomic,strong) NSArray *localImageGroups;


/**
 *  网络图片URL数组,每一个element既可以是NSURL，也可是nsurl string
 */
@property (nonatomic,strong) NSMutableArray *imageUrlGroups;

/**
 *  title 数组
 */
@property (nonatomic,strong) NSArray *titles;


/**
 *  自动滚动时间间隔,默认为1.0
 */
@property (nonatomic,assign) CGFloat autoScrollTimeInterval;


/**
 *  默认放置图片,可设置可不设置
 */
@property (nonatomic,strong) UIImage *placehodlerImage;


/**
 *  page controll 的位置
 */
@property (nonatomic,assign) GCCycleScrollPageControlAliment pageControlAliment;

/**
 *  分页控件小圆标大小
 */
@property (nonatomic, assign) CGSize pageControlDotSize;
/**
 *  分页控件小圆标颜色
 */
@property (nonatomic, strong) UIColor *dotColor;

/**
 *  title字体颜色，默认为白色
 */
@property (nonatomic, strong) UIColor *titleLabelTextColor;
/**
 *  title字体大小，默认为14
 */
@property (nonatomic, strong) UIFont *titleLabelFont;
/**
 *  title字体背景色
 */
@property (nonatomic, strong) UIColor *titleLabelBgColor;

/**
 *  标题是否隐藏
 */
@property (nonatomic,assign) BOOL iSHiddenTittleLabel;

/**
 *  title字体高度，默认为20
 */
@property (nonatomic, assign) CGFloat titleLabelHeight;


/**
 *  创建声明cycleScrollView的方式
 *
 *  @param frame       frame
 *  @param imageGroups 本地图片组，每一个元素都是UiImage
 *
 *  @return GCCycleScrollView object
 */
+ (id)cycleScrollViewWithFrame:(CGRect)frame imageGroups:(NSArray*)imageGroups;

/**
 *  创建声明cycleScrollView的方式
 *
 *  @param frame          frame
 *  @param imageURLGroups 网络图片URL组
 *
 *  @return GCCycleScrollView object
 */
+ (id)cycleScrollViewWithFrame:(CGRect)frame imageURLGroups:(NSArray *)imageURLGroups;

/**
 *  清除缓存
 */
- (void)clearCache;

@end
