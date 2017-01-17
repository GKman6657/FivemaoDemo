//
//  NSObject+Swizzling.m
//  WStarFramework
//
//  Created by jf on 16/12/15.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "NSObject+Swizzling.h"

/**
 把系统的方法交换为我们自己的方法，从而给系统方法添加一些我们想要的功能
 
 实例一：替换ViewController生命周期方法
 实例二：解决获取索引、添加、删除元素越界崩溃问题
 实例三：防止按钮重复暴力点击
 实例四：全局更换控件初始效果
 实例五：App热修复
 实例六：App异常加载占位图通用类封装
 实例七：全局修改导航栏后退（返回）按钮
 
 原文链接：http://www.jianshu.com/p/f6dad8e1b848

 */
@implementation NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector{
    Class class = [self class];
    //原有方法
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    //替换原有方法的新方法
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况              ////-----  实现的函数指针 implementation（IMP）
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {//添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class,swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {//添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
