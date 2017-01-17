//
//  YYProgressHUD.h
//  WStarFramework
//
//  Created by jf on 16/12/12.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYProgressHUD : UIView

+ (void) showErrorMsg:(NSString *) msg;
+ (void) showErrorMsg:(NSString *)msg afterDelay:(NSTimeInterval)delay;
+ (void) showLongErrorMsg:(NSString *)msg;
+ (void) showInfo:(NSString *) msg;
+ (void) showMessageOnly:(NSString *)message;  //提示一句话

+ (void) showActivityIndicatorViewOnly;
+ (void) showCustomViewImage;   //自定义图片
@end
