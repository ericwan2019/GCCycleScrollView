//
//  NSData+GCCache.h
//  GCCycleScrollViewProject
//
//  Created by 万鸿恩 on 16/3/24.
//  Copyright © 2016年 万鸿恩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (GCCache)
/**
 *  根据identifier存储数据缓存
 *
 *  @param identifier 数据缓存的唯一标识符
 */
- (void)savaDataCacheWithIdentifier:(NSString*)identifier;

/**
 *  根据identifier获取数据缓存
 *
 *  @param identifier 数据缓存的唯一标识符
 *
 *  @return 唯一标识符所对应的数据缓存
 */
+ (NSData *)getDataCacheWithIdentifier:(NSString*)identifier;


/**
 *  清除所有缓存
 */
- (void)clear;

@end
