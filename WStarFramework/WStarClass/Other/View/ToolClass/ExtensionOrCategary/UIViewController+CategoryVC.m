//
//  UIViewController+CategoryVC.m
//  WStarFramework
//
//  Created by jf on 16/12/12.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "UIViewController+CategoryVC.h"
#import "MBProgressHUD.h"
#import "Utils.h"
@implementation UIViewController (CategoryVC)


- (void) showInfo:(NSString *)msg
{
    [Utils showToastWithMessage:msg];
    
}

- (void) showErrorMsg:(NSString *)msg
{
    [Utils showToastWithMessage:msg];
}

- (void) showErrorMsg:(NSString *)msg afterDelay:(NSTimeInterval)delay
{
    [Utils showToastWithMessage:msg];
}

- (void) showLongErrorMsg:(NSString *)msg
{
    UIWindow *tempKeyboardWindow = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:tempKeyboardWindow animated:YES];
    hud.label.text = msg;
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    [hud hideAnimated:YES afterDelay:2.];
}

- (void) showSolidColorOrBlurStyle :(NSString *)msg{
    
    UIWindow *tempKeyboardWindow = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:tempKeyboardWindow animated:YES];
    hud.label.text = msg;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    [hud hideAnimated:YES afterDelay:2.];
}
@end
