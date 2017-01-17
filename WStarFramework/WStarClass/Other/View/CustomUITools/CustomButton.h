//
//  CustomButton.h
//  WStarFramework
//
//  Created by jf on 16/12/14.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

@property(nonatomic,strong)UIImageView*leftImageView;
@property(nonatomic,strong)UILabel *rightLabel;
/*
 思路： 先创建出需要的view，然后将view放在button上，再将view的用户交互关闭即可。
 
 这种自定义button的方式比较非主流，不过，此方法简单易懂、功能强大，
 
 */
@property(nonatomic,strong)UIView *customView;//（与button相关联的自定义view）

- (void)changeUI;

@end
