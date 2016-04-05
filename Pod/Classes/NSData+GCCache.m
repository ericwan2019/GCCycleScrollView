//
//  NSData+GCCache.m
//  GCCycleScrollViewProject
//
//  Created by 万鸿恩 on 16/3/24.
//  Copyright © 2016年 万鸿恩. All rights reserved.
//

#import "NSData+GCCache.h"
#import <CommonCrypto/CommonCrypto.h>

#define kGCMaxCacheFileAmount 100

@implementation NSData (GCCache)

/**
 *  设置存储的根路径
 *
 *  @return 根路径
 */
+ (NSString *)path{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)   lastObject];
    path = [path stringByAppendingPathComponent:@"tracy"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

/**
 *  根据string返回一个使用MD5加密的字符串
 *
 *  @param string
 *
 *  @return 一个使用MD5加密的字符串
 */
+ (NSString *)creatMD5StringWithString:(NSString *)string
{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    [hash lowercaseString];
    return hash;
}

/**
 *  根据string来创建一个存储路径
 *
 *  @param string
 *
 *  @return 一个存储路径
 */
+ (NSString *)creatDataPathWithString:(NSString *)string
{
    NSString *path = [NSData path];
    path = [path stringByAppendingPathComponent:[self creatMD5StringWithString:string]];
    return path;
}

/**
 *  根据identifier存储数据缓存
 *
 *  @param identifier 数据缓存的唯一标识符
 */
- (void)savaDataCacheWithIdentifier:(NSString *)identifier{
    NSString *path = [NSData creatDataPathWithString:identifier];
    
    NSLog(@"path ===== %@",path);
    
    [self writeToFile:path atomically:YES];
}

/**
 *  根据identifier获取数据缓存
 *
 *  @param identifier 数据缓存的唯一标识符
 *
 *  @return 唯一标识符所对应的数据缓存
 */
+ (NSData*)getDataCacheWithIdentifier:(NSString *)identifier{
    static BOOL isCheckedCacheDisk = NO;
    if (!isCheckedCacheDisk) {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *contents = [manager contentsOfDirectoryAtPath:[self path] error:nil];
        if (contents.count >= kGCMaxCacheFileAmount) {
            [manager removeItemAtPath:[self path] error:nil];
        }
        isCheckedCacheDisk = YES;
    }
    NSString *path = [self creatDataPathWithString:identifier];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

/**
 *  清除所有缓存
 */
+ (void)clear{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager removeItemAtPath:[NSData path] error:nil]) {
        NSLog(@"remove data cache successfully");
    }
}


@end
