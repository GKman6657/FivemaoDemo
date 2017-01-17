//
//  YYProgressHUD.m
//  WStarFramework
//
//  Created by jf on 16/12/12.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "YYProgressHUD.h"
#import "Utils.h"
#import "MBProgressHUD.h"
@implementation YYProgressHUD

+ (void) showInfo:(NSString *)msg
{
    [Utils showToastWithMessage:msg];
    
}

+ (void) showErrorMsg:(NSString *)msg
{
    [Utils showToastWithMessage:msg];
}

+ (void) showErrorMsg:(NSString *)msg afterDelay:(NSTimeInterval)delay
{
    [Utils showToastWithMessage:msg];
}

+ (void) showMessageOnly:(NSString *)message {
    
    UIWindow *tempKeyboardWindow = [[UIApplication sharedApplication] keyWindow];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:tempKeyboardWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    /*
     //    HUD.mode = MBProgressHUDModeIndeterminate;//菊花，默认值
     
     //    HUD.mode = MBProgressHUDModeDeterminate;//圆饼，饼状图
     
     //    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;//进度条
     
     HUD.mode = MBProgressHUDModeAnnularDeterminate;//圆环作为进度条
     
     //    HUD.mode = MBProgressHUDModeCustomView; //需要设置自定义视图时候设置成这个
     
     //    HUD.mode = MBProgressHUDModeText; //只显示文本
     
     文／wu琼（简书作者）
     原文链接：http://www.jianshu.com/p/51f8a81076ed
     著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
     
     */
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:13];
    hud.contentColor = [UIColor colorWithRed:0.f green:0.6f blue:0.7f alpha:1.f];
    
    hud.userInteractionEnabled = NO;
    [hud showAnimated:YES];
    
    [hud hideAnimated:YES afterDelay:2.0f];
}
+ (void) showActivityIndicatorViewOnly {
     UIWindow *tempKeyboardWindow = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:tempKeyboardWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = YES;
   
    hud.bezelView.color = [UIColor magentaColor];
    hud.bezelView.layer.cornerRadius = 20.0; //背景框的圆角值，默认是10
    hud.bezelView.alpha = 0.5;
    hud.animationType = MBProgressHUDAnimationFade; //默认类型的，渐变
  
    [hud hideAnimated:YES afterDelay:2.0];
}

+ (void) showCustomViewImage {
    UIWindow *tempKeyboardWindow = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:tempKeyboardWindow animated:YES];
     hud.mode = MBProgressHUDModeCustomView;
    
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
     hud.square = YES;
    hud.label.text = NSLocalizedString(@"完成", @"HUD done title");
    [hud showAnimated:YES];
    
    [hud hideAnimated:YES afterDelay:2.0f];

}

@end
