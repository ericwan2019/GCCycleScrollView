//
//  MainViewController.m
//  GCCycleScrollViewProject
//
//  Created by 万鸿恩 on 16/3/28.
//  Copyright © 2016年 万鸿恩. All rights reserved.
//

#import "MainViewController.h"
#import "GCCycleScrollView.h"

@interface MainViewController ()<GCCycleScrollViewDelegate>

@end


@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
//    //本地图片加载
//    GCCycleScrollView *cyc = [[GCCycleScrollView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 170)];
//    cyc.delegate =self;
//    NSArray *images = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"3"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"5"],[UIImage imageNamed:@"2"],nil];
//    cyc.localImageGroups = images;
//    cyc.autoScrollTimeInterval = 3.0;
//    cyc.dotColor = [UIColor greenColor];
//    [self.view addSubview:cyc];
    
    
    
    //网络图片加载
    GCCycleScrollView *cycurl = [[GCCycleScrollView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 170)];
    cycurl.delegate =self;
    NSArray *urlimages = [[NSArray alloc] initWithObjects:@"http://pics.sc.chinaz.com/files/pic/pic9/201603/apic19563.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201603/apic19747.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201603/apic19515.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201602/apic18951.jpg",nil];
    cycurl.imageUrlGroups = urlimages;
    cycurl.autoScrollTimeInterval = 3.0;
    cycurl.dotColor = [UIColor greenColor];
    [self.view addSubview:cycurl];
    
}

-(void)cycleScrollView:(GCCycleScrollView *)cycleScrollView didSelectItemAtRow:(NSInteger)row{
    NSLog(@"dianji =%ld",(long)row);
    
    UIAlertController *alertCOntroller = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"你点击来%ld第行",(long)row] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertCOntroller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertCOntroller animated:YES completion:nil];
    
}


@end
