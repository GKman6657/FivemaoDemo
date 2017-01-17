//
//  UIColor+Category.h
//  WStarFramework
//
//  Created by jf on 16/12/14.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)
/* 从十六进制字符串获取颜色 带透明参数*/
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
