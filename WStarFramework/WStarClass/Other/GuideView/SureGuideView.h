//
//  SureGuideView.h
//  ProjectRefactoring
//
//  Created by wmx on 2016/12/17.
//  Copyright © 2016年 wmx. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import <UIKit/UIKit.h>

extern NSString *const SureShouldShowGuide;

@interface SureGuideView : UIView

@property (nonatomic, copy) void(^lastTapBlock)(void);

+ (instancetype)sureGuideViewWithImageName:(NSString*)imageName
                                imageCount:(NSInteger)imageCount;

+ (BOOL)shouldShowGuider;

- (void)show;

@end
