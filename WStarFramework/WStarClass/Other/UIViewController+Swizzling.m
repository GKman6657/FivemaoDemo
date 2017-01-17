//
//  UIViewController+Swizzling.m
//  WStarFramework
//
//  Created by jf on 16/11/21.
//  Copyright © 2016年 jf. All rights reserved.
//

/**
在每一个页面出现的时候，都打印出哪个类即将出现  快速让你上手一个大项目

 */
#import "UIViewController+Swizzling.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@implementation UIViewController (Swizzling)

+ (void)load {
//我们只有在开发的时候才需要查看哪个viewController将出现
//所以在release模式下就没必要进行方法的交换
#ifdef DEBUG

//原本的viewWillAppear方法
Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));

//需要替换成 能够输出日志的viewWillAppear
Method logViewWillAppear = class_getInstanceMethod(self, @selector(logViewWillAppear:));

//两方法进行交换
method_exchangeImplementations(viewWillAppear, logViewWillAppear);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(viewWillDisappear:) bySwizzledSelector:@selector(sure_viewWillDisappear:)];
    });

#endif
}

- (void)logViewWillAppear:(BOOL)animated {
    
    NSString *className = NSStringFromClass([self class]);
    
    //在这里，你可以进行过滤操作，指定哪些viewController需要打印，哪些不需要打印
    if ([className hasPrefix:@"UI"] == NO) {
        NSLog(@"-------->%@ will appear",className);
    }
    
    
    //下面方法的调用，其实是调用viewWillAppear
    [self logViewWillAppear:animated];
}


- (void)sure_viewWillDisappear:(BOOL)animated {
    [self sure_viewWillDisappear:animated];
    NSLog(@"视图将要消失  在这里处理 \n譬如：移除  菊花圈 或者 界面背景颜色");
}
@end
