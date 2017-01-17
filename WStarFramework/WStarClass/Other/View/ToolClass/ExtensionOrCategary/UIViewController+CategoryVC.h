//
//  UIViewController+CategoryVC.h
//  WStarFramework
//
//  Created by jf on 16/12/12.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CategoryVC)

- (void) showInfo:(NSString *) msg;
- (void) showErrorMsg:(NSString *) msg;
- (void) showErrorMsg:(NSString *)msg afterDelay:(NSTimeInterval)delay;
- (void) showLongErrorMsg:(NSString *)msg;

- (void) showSolidColorOrBlurStyle :(NSString *)msg ;  //毛玻璃  或者半透明效果

@end
