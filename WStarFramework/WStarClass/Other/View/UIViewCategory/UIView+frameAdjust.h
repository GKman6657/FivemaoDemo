//
//  UIView+frameAdjust.h
//  WStarFramework
//
//  Created by jf on 16/12/14.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frameAdjust)
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat top;
@property (nonatomic, assign) CGSize size;
// 底部
- (CGFloat)bottom;
- (CGFloat)top;
// 左上角x坐标
- (CGFloat)x;
- (void)setX:(CGFloat)x;

// 左上角y坐标
- (CGFloat)y;
- (void)setY:(CGFloat)y;

// 宽
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

// 高
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

// 中心点x
- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)x;

// 中心点y
- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)y;

/** 获取最大x */
- (CGFloat)maxX;
- (void)setMaxX:(CGFloat)mx;
/** 获取最小x */
- (CGFloat)minX;

/** 获取最大y */
- (CGFloat)maxY;
- (void)setMaxY:(CGFloat)my;
/** 获取最小y */
- (CGFloat)minY;



/** 获取当前view所在的viewController */
- (UIViewController *)getCurrentViewController;

@end
