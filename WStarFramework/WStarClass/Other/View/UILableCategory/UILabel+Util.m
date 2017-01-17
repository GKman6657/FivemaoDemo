//
//  UILabel+Util.m
//  WStarFramework
//
//  Created by jf on 16/12/14.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "UILabel+Util.h"
#import "UIView+frameAdjust.h"

#import "NSObject+Swizzling.h"

@implementation UILabel (Util)

/** 将label的宽度调整到适应文本内容的最低值 */
- (void)adjustWidthToMin{
    // 先记录label原本的中心Y
    CGFloat centerY = self.centerY;
    // 调整label
    [self sizeToFit];
    // 调整中心
    self.centerY = centerY;
}


/**
 
  全局更换控件初始效果  引入新的字体
 */
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(init) bySwizzledSelector:@selector(sure_Init)];
        [self methodSwizzlingWithOriginalSelector:@selector(initWithFrame:) bySwizzledSelector:@selector(sure_InitWithFrame:)];
        [self methodSwizzlingWithOriginalSelector:@selector(awakeFromNib) bySwizzledSelector:@selector(sure_AwakeFromNib)];
    });
}
- (instancetype)sure_Init{
    id __self = [self sure_Init];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font=font;
    }
    return __self;
}
- (instancetype)sure_InitWithFrame:(CGRect)rect{
    id __self = [self sure_InitWithFrame:rect];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font=font;
    }
    return __self;
}
- (void)sure_AwakeFromNib{
    [self sure_AwakeFromNib];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font=font;
    }
}
@end
