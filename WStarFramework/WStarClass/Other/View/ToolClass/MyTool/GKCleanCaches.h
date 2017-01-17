//
//  GKCleanCaches.h
//  WStarFramework
//
//  Created by jf on 16/12/16.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKCleanCaches : NSObject

@property (nonatomic,assign)float garbageFloat; //废弃物
- (void)setGarbageFloat:(float)garbageFloat;

//获取缓存路径
+ (NSString *)getCachesPath:(NSString *)fileName;
+ (float)fileSizeAtPath:(NSString *)path;  // 1.计算单个文件大小

+ (float)folderSizeAtPath:(NSString *)path; //2. 计算文件夹大小(要利用上面的1提供的方法)


+ (void)clearCache:(NSString *)path;        //// 3.清除缓存

/**

 *
 *  清除path路径文件夹的缓存
 *
 *  @param path  要清除缓存的文件夹全路径
 *
 *  @return 是否清除成功
 */
+ (BOOL)clearCacheWithFilePath:(NSString *)path;
@end
