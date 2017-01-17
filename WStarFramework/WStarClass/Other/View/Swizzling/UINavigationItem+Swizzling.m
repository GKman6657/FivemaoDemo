//
//  UINavigationItem+Swizzling.m
//  WStarFramework
//
//  Created by jf on 16/12/15.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "UINavigationItem+Swizzling.h"
#import "NSObject+Swizzling.h"
static char *kCustomBackButtonKey;
@implementation UINavigationItem (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(backBarButtonItem)
                               bySwizzledSelector:@selector(sure_backBarButtonItem)];
        
    });
}

- (UIBarButtonItem*)sure_backBarButtonItem {
    UIBarButtonItem *backItem = [self sure_backBarButtonItem];
    if (backItem) {
        return backItem;
    }
    backItem = objc_getAssociatedObject(self, &kCustomBackButtonKey);
    if (!backItem) {     //这里进行将返回按钮的文字清空操作
        
        backItem = [[UIBarButtonItem alloc] initWithTitle:@"这是类别统一设置的" style:UIBarButtonItemStylePlain target:nil action:NULL];
        objc_setAssociatedObject(self, &kCustomBackButtonKey, backItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backItem;
}

@end
