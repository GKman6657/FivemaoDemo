//
//  Utils.h
//  WStarFramework
//
//  Created by jf on 16/12/12.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utils : NSObject

+ (void)showToastWithMessage:(NSString *)mesage;  //提示框
+ (void)showToastWithMessage:(NSString *)mesage inView:(UIView*)view;

+(UIColor*)colorWithHexStr:(NSString *)stringToConvert;   //颜色值

/**
 手机号码  邮箱  身份证  
 */
@end
