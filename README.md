
GCCycleScrollView supports auto scroll and drag of imageview which can be used for Ads repeat scroll (Viwepager function) iOS. Support image data cache and clear cahce function. For each  imageview you can add its title and custom set title labe property or use default title label property.
<br>GCCycleScrollView用于iOS 广告等图片展示轮播，支持无限循环播放，以及拖拽功能.GCCycleScrollView对于每一张图片都可以添加自己的标题以及设置标题label的相关属性或者使用默认的设置。

# GCCycleScrollView

[![CI Status](http://img.shields.io/travis/EricWan/GCCycleScrollView.svg?style=flat)](https://travis-ci.org/EricWan/GCCycleScrollView)
[![Version](https://img.shields.io/cocoapods/v/GCCycleScrollView.svg?style=flat)](http://cocoapods.org/pods/GCCycleScrollView)
[![License](https://img.shields.io/cocoapods/l/GCCycleScrollView.svg?style=flat)](http://cocoapods.org/pods/GCCycleScrollView)
[![Platform](https://img.shields.io/cocoapods/p/GCCycleScrollView.svg?style=flat)](http://cocoapods.org/pods/GCCycleScrollView)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation(安装)

GCCycleScrollView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GCCycleScrollView"
```

##Manual Install(手动导入)
Download the Project and then drag "lib"file to your own project.首先下载该项目，把项目中的lib文件夹拉入自己的项目。
```
#import "GCCycleScrollView.h"
```


##Example（例子）
=====
```
    //load local images 本地图片加载
    GCCycleScrollView *cycleScroll = [[GCCycleScrollView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 170)];
    cycleScroll.delegate =self;
    NSArray *images = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"3"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"5"],[UIImage imageNamed:@"2"],nil];
    cycleScroll.localImageGroups = images;
    cycleScroll.autoScrollTimeInterval = 3.0;
    cycleScroll.dotColor = [UIColor greenColor];
    [self.view addSubview:cycleScroll];
```
```
//load images from website 网络图片加载
    GCCycleScrollView *cycleScroll = [[GCCycleScrollView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 170)];
    cycleScroll.delegate =self;
    NSArray *urlimages = [[NSArray alloc] initWithObjects:@"http://pics.sc.chinaz.com/files/pic/pic9/201603/apic19563.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201603/apic19747.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201603/apic19515.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201602/apic18951.jpg",nil];
    cycleScroll.imageUrlGroups = urlimages;
    cycleScroll.autoScrollTimeInterval = 3.0;
    cycleScroll.dotColor = [UIColor greenColor];
    [self.view addSubview:cycleScroll];
```
```
//clear image data cache清除图片缓存
[cycleScroll clearCache];
```
```
//pageCOntroll location; pageCOntroll的位置
typedef NS_ENUM(NSInteger,GCCycleScrollPageControlAliment){
    /**
     *  page control 位于中间，默认在中间 center default value
     */
    GCCycleScrollPageControlAlimentCenter = 0,
    
    /**
     *  page control 位于右侧 right side
     */
    GCCycleScrollPageControlAlimentRight = 1,
    
    /**
     *  page control 位于左侧 left side
     */
    GCCycleScrollPageControlAlimentLeft = 2
};
```

## Author

EricWan, 1396855545@qq.com

## License

GCCycleScrollView is available under the MIT license. See the LICENSE file for more info.
=======
# GCCycleScrollView

