//
//  CustomMiddleBar.h
//  WStarFramework
//
//  Created by jf on 16/11/15.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomMiddleBar;

@protocol CustomMiddleBarDelegate <UITabBarDelegate>

- (void)middlebarDidClickPlusButton:(CustomMiddleBar *)tabBar;

@end

@interface CustomMiddleBar : UITabBar

@property (nonatomic,weak)id<CustomMiddleBarDelegate>delegate;

@end
