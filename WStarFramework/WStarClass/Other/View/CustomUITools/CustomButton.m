//
//  CustomButton.m
//  WStarFramework
//
//  Created by jf on 16/12/14.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 左边图片
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2.5, 25, 25)];
        [self addSubview:_leftImageView];
        _leftImageView.image = [UIImage imageNamed:@"freshchose2"];
        
        // 右边label
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame), 0, self.frame.size.width-20, self.frame.size.height)];
        [self addSubview:_rightLabel];
        _rightLabel.font = [UIFont boldSystemFontOfSize:13];
        _rightLabel.adjustsFontSizeToFitWidth = YES;
        _rightLabel.text = @"分类";
    }
    return self;
}

#pragma mark - 点击按钮，改变其UI
- (void)changeUI{
    // label显隐状态交替
    _rightLabel.hidden = !_rightLabel.hidden;
    
    // imageView旋转90度
    static float angle = M_PI/2;
    [UIView animateWithDuration:0.3 animations:^{
        _leftImageView.transform = CGAffineTransformMakeRotation(angle);
    }];
    angle += M_PI/2;
}
#pragma mark - 重写layoutSubviews方法
//根据button是否会动态变化决定是否重写layoutSubviews方法
- (void)layoutSubviews{
    // 由于不涉及动态变化，所以无需重写😅
}

-(void)setCustomView:(UIView *)customView{
    // 让customView覆盖在button上
    customView.frame = self.bounds;
    [self addSubview:customView];
    // 关闭customView的用户交互
    customView.userInteractionEnabled = NO;
}


@end
