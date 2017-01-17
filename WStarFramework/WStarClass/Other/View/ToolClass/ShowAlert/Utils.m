//
//  Utils.m
//  WStarFramework
//
//  Created by jf on 16/12/12.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "Utils.h"
#import "MBProgressHUD.h"
@implementation Utils

+ (void)showToastWithMessage:(NSString *)mesage
{
    UIWindow *winodw = [UIApplication sharedApplication].keyWindow;
    [self showToastWithMessage:mesage inView:winodw];
}
+ (void)showToastWithMessage:(NSString *)mesage inView:(UIView*)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    /*
  
     MBProgressHUDModeIndeterminate,                 /// UIActivityIndicatorView.
    
     MBProgressHUDModeDeterminate,                    /// A round, pie-chart like, progress view.
    
     MBProgressHUDModeDeterminateHorizontalBar,      /// Horizontal progress bar.
     
     MBProgressHUDModeAnnularDeterminate,            /// Ring-shaped progress view.
     
     MBProgressHUDModeCustomView,                    /// Shows a custom view.
     
     MBProgressHUDModeText                           /// Shows only labels.
     */
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType= MBProgressHUDAnimationFade;//进度条的动画效果
    hud.label.textColor = [UIColor blueColor];
    
    hud.label.text = mesage;
    hud.detailsLabel.text = @"牛逼的详情";
    
    hud.userInteractionEnabled = YES;
    [hud hideAnimated:YES afterDelay:2.0];
}

//将十六进制颜色字符串转化为UIColor
+ (UIColor *) colorWithHexStr: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return nil;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return nil;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
