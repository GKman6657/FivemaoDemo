//
//  MyTools.h
//  WStarFramework
//
//  Created by jf on 16/12/16.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTools : NSObject
// 封装常用的正则表达式
+ (BOOL) checkTelNumber:(NSString *) telNumber; //手机号
+ (BOOL) checkPassword:(NSString *) password;  //密码
+ (BOOL) checkUserName : (NSString *) userName;  //用户名
+ (BOOL) checkUserIdCard: (NSString *) idCard;  //身份证
+ (BOOL) checkURL : (NSString *) url;             //url
+ (BOOL)isAvailableEmail:(NSString *)email;      //邮箱
+ (BOOL)isHaveSpaceInString:(NSString *)string ;  //字符串空格
+ (void)backOutApp  ;                              //退出App
@end
