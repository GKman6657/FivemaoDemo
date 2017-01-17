//
//  UILabel+Util.h
//  WStarFramework
//
//  Created by jf on 16/12/14.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Util)
//让UILabel的宽度随文本内容多少而改变。UILabel有一个方法sizeToFit可以完成这个任务，但是，sizeToFit使用后，UILabel的文字就跑到左上角了

/** 将label的宽度调整到适应文本内容的最低值 */
- (void)adjustWidthToMin;


@end
