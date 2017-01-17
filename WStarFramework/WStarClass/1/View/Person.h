//
//  Person.h
//  WStarFramework
//
//  Created by jf on 16/11/17.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>

@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * sex;
@property (nonatomic,assign)NSUInteger age;


@end


@interface User  : NSObject

@property(nonatomic,copy)NSString * name ;
@property(nonatomic,copy)NSString * sex ;
@property (nonatomic,strong)NSNumber * age;
+ (instancetype)user;

@end

