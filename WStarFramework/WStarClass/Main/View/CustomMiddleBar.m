//
//  CustomMiddleBar.m
//  WStarFramework
//
//  Created by jf on 16/11/15.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "CustomMiddleBar.h"
@interface CustomMiddleBar ()

@property (nonatomic, strong) UIButton *plusBtn;

@end

@implementation CustomMiddleBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
       
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.plusBtn = button;
        
//        [self.plusBtn setBackgroundImage:[UIImage imageNamed:@"bg_tabbar"] forState:UIControlStateNormal];
//        [self.plusBtn setBackgroundImage:[UIImage imageNamed:@"bg_tabbar~iphone"] forState:UIControlStateHighlighted];
        
        [self.plusBtn setImage:[UIImage imageNamed:@"button_write"] forState:UIControlStateNormal];
        [self.plusBtn setImage:[UIImage imageNamed:@"button_write~iphone"] forState:UIControlStateHighlighted];
        
        [self.plusBtn sizeToFit];
        
        [self.plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.plusBtn];
        
    }
    return self;
}

/**
 *  加号按钮点击
 */
- (void)plusBtnClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(middlebarDidClickPlusButton:)]) {
        [self.delegate middlebarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews {
    
     [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnx = 0;
    CGFloat btny = 0;
    //5.0是tabbar中的控件的数量
    CGFloat width = self.bounds.size.width/5.0;
    CGFloat height = self.bounds.size.height;
    
    int i=0;
    
    for (UIView *btn in self.subviews) {
        //判断是否是系统自带的UITabBarButton类型的控件
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i==2) {
                i++;
            }
            btnx = i*width;
            
            btn.frame = CGRectMake(btnx, btny, width, height);
            
            i++;
            
        }
        //设置自定义button的位置
        self.plusBtn.center = CGPointMake(w*0.5, h*0.5); 
        
    }
    
    
}

@end
