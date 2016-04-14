//
//  GCCycleScrollView.m
//  GCCycleScrollViewProject
//
//  Created by 万鸿恩 on 16/3/28.
//  Copyright © 2016年 万鸿恩. All rights reserved.
//

#import "GCCycleScrollView.h"
#import "UIView+Frame.h"
#import "NSData+GCCache.h"
#import "GCScrollViewCell.h"
#import "TAPageControl.h"


#define kCycleScrollCell @"tracyCell"



@interface GCCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
/**
 *  存储来自本地图片数组和URL图片数组
 */
@property (nonatomic, strong) NSMutableArray *imagesGroup;
/**
 *  计时器
 */
@property (nonatomic, strong) NSTimer *timer;
/**
 *  pagecontrol
 */
@property (nonatomic, strong) TAPageControl *pageControl;
@end

@implementation GCCycleScrollView



#pragma mark - init

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initial];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initial];
    }
    return self;
}

- (void)initial{
    _pageControlAliment = GCCycleScrollPageControlAlimentCenter;
    _autoScrollTimeInterval = 1.0;
    _titleLabelFont = [UIFont systemFontOfSize:14];
    _titleLabelHeight = 30;
    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelBgColor = GCColorWithAlpha(0, 0, 0, 0.4);
    self.backgroundColor = [UIColor whiteColor];
}


/**
 *  创建声明cycleScrollView的方式
 *
 *  @param frame       frame
 *  @param imageGroups 本地图片组，每一个元素都是UiImage
 *
 *  @return GCCycleScrollView object
 */
+ (id)cycleScrollViewWithFrame:(CGRect)frame imageGroups:(NSArray *)imageGroups{
    GCCycleScrollView *cycleScrollView = [[GCCycleScrollView alloc] initWithFrame:frame];
    cycleScrollView.imagesGroup = [NSMutableArray arrayWithArray:imageGroups];
    return cycleScrollView;
}

/**
 *  创建声明cycleScrollView的方式
 *
 *  @param frame          frame
 *  @param imageURLGroups 网络图片URL组
 *
 *  @return GCCycleScrollView object
 */
+ (id)cycleScrollViewWithFrame:(CGRect)frame imageURLGroups:(NSArray *)imageURLGroups{
    GCCycleScrollView *cycleScrollView = [[GCCycleScrollView alloc] initWithFrame:frame];
    cycleScrollView.imageUrlGroups = [NSMutableArray arrayWithArray:imageURLGroups];
    return cycleScrollView;
}



#pragma mark - setting
/**
 *  设置pageControl圆点的size
 */
-(void)setPageControlDotSize:(CGSize)pageControlDotSize{
    _pageControlDotSize = pageControlDotSize;
    _pageControl.dotSize = pageControlDotSize;
}
/**
 *  设置pagecontrol的颜色
 */
-(void)setDotColor:(UIColor *)dotColor{
    _dotColor = dotColor;
    _pageControl.dotColor  =dotColor;
}

/**
 *  设置自动滚动的时间间隔
 */
-(void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    //每次设定的时候需要先终止之前的timer
    [_timer invalidate];
    _timer = nil;
    [self setUpTimer];
}

/**
 *  设置默认的placeholder 图片
 */
-(void)setPlacehodlerImage:(UIImage *)placehodlerImage{
    _placehodlerImage = placehodlerImage;
    [self setUpScrollViewContent];//刷新设置的属性
}

/**
 *  设置pagecontrol
 */
- (void)setUpPageControll{
    if (_pageControl) {
        [_pageControl removeFromSuperview];//避免重复加载
    }
    _pageControl = [[TAPageControl alloc] init];
    _pageControl.numberOfPages = self.imagesGroup.count;
    _pageControl.dotColor = self.dotColor;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
}

/**
 *  设置保存最终图片的数组
 */
- (void)setImagesGroup:(NSMutableArray *)imagesGroup{
    _imagesGroup = imagesGroup;
    //    if (imagesGroup.count !=1) {
    ////        [self setUpTimer];
    //    }else{
    //        self.scrollView.scrollEnabled = NO;
    //    }
    [self setUpScrollViewContent];
}
/**
 *  设置保存本地图片的数组
 */
- (void)setLocalImageGroups:(NSArray *)localImageGroups{
    _localImageGroups = localImageGroups;
    self.imagesGroup = [NSMutableArray arrayWithArray:localImageGroups];
}

/**
 *  设置保存网络图片URL的数组
 */
- (void)setImageUrlGroups:(NSMutableArray *)imageUrlGroups{
    
    _imageUrlGroups = imageUrlGroups;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:_imageUrlGroups.count];
    for (int i = 0; i < imageUrlGroups.count; i++) {
        UIImage *image = [[UIImage alloc] init];
        [images addObject:image];
    }
    self.imagesGroup = images;
    [self loadImageWithUrlGroups:imageUrlGroups];
}

/**
 *  设置标题数组
 */
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self setUpScrollViewContent];
}
/**
 *  设置标题背景色
 */
- (void)setTitleLabelBgColor:(UIColor *)titleLabelBgColor{
    _titleLabelBgColor = titleLabelBgColor;
    [self setUpScrollViewContent];//刷新设置的属性
}
/**
 *  设置标题高度
 */
- (void)setTitleLabelHeight:(CGFloat)titleLabelHeight{
    _titleLabelHeight = titleLabelHeight;
    [self setUpScrollViewContent];//刷新设置的属性
}
/**
 *  设置标题字体颜色
 */
- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor{
    _titleLabelTextColor = titleLabelTextColor;
    [self setUpScrollViewContent];//刷新设置的属性
}
/**
 *  设置标题字体
 */
- (void)setTitleLabelFont:(UIFont *)titleLabelFont{
    _titleLabelFont = titleLabelFont;
    [self setUpScrollViewContent];//刷新设置的属性
}




/**
 *  设定计时器
 */
- (void)setUpTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  自动滚动
 */
-(void)autoScroll{
    if (self.imagesGroup.count > 0)
    {
        CGFloat pageWidth = self.scrollView.width;
        int currentPage = self.scrollView.contentOffset.x/pageWidth;
        if (currentPage==0) {
            self.pageControl.currentPage = self.imagesGroup.count-1;
        }else if (currentPage==self.imagesGroup.count+1){
            self.pageControl.currentPage=0;
        }else{
            self.pageControl.currentPage = currentPage-1;
        }
        NSInteger currentPageNum = self.pageControl.currentPage;
        
        CGSize viewSize = self.scrollView.size;
        CGRect rect = CGRectMake((currentPageNum+2)*pageWidth, 0, viewSize.width, viewSize.height);
        [self.scrollView scrollRectToVisible:rect animated:YES];
        
        currentPageNum++;
        if (currentPageNum == self.imagesGroup.count) {
            [self.scrollView scrollRectToVisible:CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height) animated:NO];
            currentPageNum=0;
        }
        self.pageControl.currentPage = currentPageNum;
        
    }
    
}

/**
 *  加载URL 图片
 */
- (void)loadImageWithUrlGroups:(NSArray*)Urls{
    for (NSInteger i=0; i<Urls.count; i++) {
        [self loadImageAndReplaceItemAtIndex:i];
    }
}
/**
 *  分别加载每一张图片，并保存在缓存当中，以便下一次的从缓存读取
 */
- (void)loadImageAndReplaceItemAtIndex:(NSInteger)index{
    NSURL *url = [self.imageUrlGroups[index] isKindOfClass:[NSURL class]] ? self.imageUrlGroups[index]:[NSURL URLWithString:self.imageUrlGroups[index]];
    
    // 如果有缓存，直接加载缓存
    NSData *data = [NSData getDataCacheWithIdentifier:url.absoluteString];
    if (data) {
        [self.imagesGroup setObject:[UIImage imageWithData:data] atIndexedSubscript:index];
        [self setUpScrollViewContent];
    } else {
        // 网络加载图片并缓存图片
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                           queue:[[NSOperationQueue alloc] init]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                                   if (!connectionError) {
                                       
                                       UIImage *image = [UIImage imageWithData:data];
                                       if (!image) return; // 防止错误数据导致崩溃
                                       [self.imagesGroup setObject:image atIndexedSubscript:index];
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [self setUpScrollViewContent];
                                       });
                                       [data savaDataCacheWithIdentifier:url.absoluteString];
                                   } else { // 加载数据失败
                                       static int repeat = 0;
                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                           if (repeat > 10) return;
                                           [self loadImageAndReplaceItemAtIndex:index];
                                           repeat++;
                                       });
                                       
                                   }
                               }
         
         ];
    }
}


#pragma mark - setting scrollview
- (void)setUpScrollView{
    if (self.scrollView) {
        [self.scrollView removeFromSuperview];//避免重复加载
    }
    [self addSubview:self.scrollView];
    [self setUpPageControll];
}

- (void)setUpScrollViewContent{
    [self setUpScrollView];
    
    for (NSInteger i=0; i<self.imagesGroup.count; i++) {
        GCScrollViewCell *cell = [[GCScrollViewCell alloc] initWithFrame:CGRectMake(self.scrollView.width*(i+1), 0, self.scrollView.width, self.scrollView.height)];
        UIImage *image = self.imagesGroup[i];
        if (image.size.width ==0 && self.placehodlerImage) {
            image = self.placehodlerImage;
        }
        cell.imgView.image = image;
        if (_titles.count) {
            cell.title = _titles[i];
        }
        cell.titleLabelBgColor = self.titleLabelBgColor;
        cell.titleLabelHeight = self.titleLabelHeight;
        cell.titleLabelTextColor = self.titleLabelTextColor;
        cell.titleLabelFont = self.titleLabelFont;
        [self.scrollView addSubview:cell];
    }
    
    if (self.imagesGroup.count) {
        //把最后一张图片加入到scrollView最前面面
        GCScrollViewCell *first = [[GCScrollViewCell alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height)];
        UIImage *image = self.imagesGroup[self.imagesGroup.count-1];
        if (image.size.width ==0 && self.placehodlerImage) {
            image = self.placehodlerImage;
        }
        first.imgView.image = image;
        if (_titles.count) {
            first.title = _titles[self.imagesGroup.count-1];
        }
        first.titleLabelBgColor = self.titleLabelBgColor;
        first.titleLabelHeight = self.titleLabelHeight;
        first.titleLabelTextColor = self.titleLabelTextColor;
        first.titleLabelFont = self.titleLabelFont;
        [self.scrollView addSubview:first];
        
        //把第一张图片加入到scrollView最后面
        GCScrollViewCell *last = [[GCScrollViewCell alloc] initWithFrame:CGRectMake(self.scrollView.width*(self.imagesGroup.count+1), 0, self.scrollView.width, self.scrollView.height)];
        UIImage *image1 = self.imagesGroup[0];
        if (image1.size.width ==0 && self.placehodlerImage) {
            image1 = self.placehodlerImage;
        }
        last.imgView.image = image1;
        if (_titles.count) {
            last.title = _titles[0];
        }
        last.titleLabelBgColor = self.titleLabelBgColor;
        last.titleLabelHeight = self.titleLabelHeight;
        last.titleLabelTextColor = self.titleLabelTextColor;
        last.titleLabelFont = self.titleLabelFont;
        [self.scrollView addSubview:last];
    }
    
    // 默认从序号1位置放第1页 ，序号0位置位置放第4页
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO];
    
    // 添加手势，来处理点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
    
    //每一次setup之后要重新开始计时
    [_timer invalidate];
    _timer = nil;
    [self setUpTimer];
}


/**
 *  点击图片的时候 触发
 */
- (void)singleTap:(UITapGestureRecognizer *)tapGesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtRow:)]) {
        [self.delegate cycleScrollView:self didSelectItemAtRow:self.pageControl.currentPage];
    }
}


/**
 *  清除缓存
 */
-(void)clearCache{
    [NSData clear];
}

/**
 *  销毁timer
 */
- (void)dealloc{
    [_timer invalidate];
    _timer = nil;
}

/**
 *  解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
 */
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _scrollView.frame = CGRectMake(0, 0, self.width, self.height);
    
    
    CGSize size = [_pageControl sizeForNumberOfPages:self.imagesGroup.count];
    CGFloat pageControllX = (self.width - size.width)/2.0;
    if (self.pageControlAliment == GCCycleScrollPageControlAlimentLeft) {
        pageControllX =16;
    }else if (self.pageControlAliment == GCCycleScrollPageControlAlimentRight){
        pageControllX = self.width - size.width - 16;
    }
    
    CGFloat pageControllY = self.height - size.height - 16;
    
    _pageControl.frame = CGRectMake(pageControllX, pageControllY, size.width, size.height);
    [_pageControl sizeToFit];
}

#pragma mark - UIScrollView
-(UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView setScrollEnabled:YES];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(self.scrollView.width*(self.imagesGroup.count+2),self.scrollView.height);
    }
    return _scrollView;
}



#pragma  mark - UIScrollViewDelegate
//当手滑动开始的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];
    _timer = nil;
    
}

//当手滑动结束的时候
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = self.scrollView.size.width;
    CGFloat heigth = self.scrollView.size.height;
    //当手指滑动scrollview，而scrollview减速停止的时候 开始计算当前的图片的位置
    //    int currentPage = self.scrollView.contentOffset.x/width;
    int currentPage = floor((self.scrollView.contentOffset.x - width/ (self.imagesGroup.count+2)) / width) + 1;
    
    NSLog(@"currentPage===%d",currentPage);
    
    if (currentPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(width*self.imagesGroup.count, 0, width, heigth) animated:NO];
        self.pageControl.currentPage = self.imagesGroup.count-1;
    }
    else if (currentPage == self.imagesGroup.count+1) {
        
        [self.scrollView scrollRectToVisible:CGRectMake(width, 0, width, heigth) animated:NO];
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
    NSLog(@"self.pageControl.currentPage===%ld",(long)self.pageControl.currentPage);
    //重新开始计时器
    [self setUpTimer];
}

@end
