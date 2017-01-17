//
//  GlobalInfo.m
//  WStarFramework
//
//  Created by jf on 16/12/12.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "GlobalInfo.h"
#import "MBProgressHUD.h"
@implementation GlobalInfo

+ (void) showErrorMsg:(NSString *)msg
{
    UIWindow *tempKeyboardWindow = [[UIApplication sharedApplication] keyWindow];
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:tempKeyboardWindow animated:YES];
    
//    当添加多个HUD的时候，MBProgressHUD提供隐藏的快捷方法：
//    [MBProgressHUD hideAllHUDsForView:tempKeyboardWindow animated:YES];
    
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = msg;
    hud.detailsLabel.text = @"牛逼的详情";
    
    hud.userInteractionEnabled = NO;
    [hud showAnimated:YES];

    [hud hideAnimated:YES afterDelay:2.0f];
}

@end
