//
//  Person.m
//  WStarFramework
//
//  Created by jf on 16/11/17.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "Person.h"   //对自定义对象 归档解档

@implementation Person


//编码
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeInteger:_age forKey:@"age"];
}

//反编码  解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        
        _name = [aDecoder decodeObjectForKey:@"name"];
        _sex = [aDecoder decodeObjectForKey:@"sex"];
        
        _age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return  self;
}
@end


@implementation User

+ (instancetype)user {
    User * person =[[self alloc]init];
    
    return person;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"--%@--%@--%@",_name,_sex,_age];
}



@end
