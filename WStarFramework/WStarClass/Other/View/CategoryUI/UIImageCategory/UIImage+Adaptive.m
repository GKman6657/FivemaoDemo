//
//  UIImage+Adaptive.m
//  ProjectRefactoring
//
//  Created by 刘硕 on 2016/11/17.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "UIImage+Adaptive.h"
#define IS_iPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size): NO)
#define IS_iPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size): NO)
#define IS_iPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size)): NO)
#define IS_iPHONE6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2208),[[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1125, 2001),[[UIScreen mainScreen] currentMode].size)): NO)
@implementation UIImage (Adaptive)

+ (instancetype)imageAdaptiveNamed:(NSString*)imagename {
    NSString *realImageName = imagename;
    //当前设备为iphone4/4S
    if (IS_iPHONE4) {
        realImageName = [NSString stringWithFormat:@"%@_iphone4",realImageName];
    }
    //当前设备为iphone5/5S
    if (IS_iPHONE5) {
        realImageName = [NSString stringWithFormat:@"%@_iphone5",realImageName];
    }
    //当前设备为iphone6/6S/7
    if (IS_iPHONE6) {
        realImageName = [NSString stringWithFormat:@"%@_iphone6",realImageName];
    }
    //当前设备为iphone6P/6SP/7P
    if (IS_iPHONE6P) {
        realImageName = [NSString stringWithFormat:@"%@_iphone6p",realImageName];
    }
    return [self imageNamed:realImageName];
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *)transformWidth:(CGFloat)width height:(CGFloat)height{
    
    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), 4*width, CGImageGetColorSpace(imageRef), (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    return resultImage;
}

-(UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    if (imageSize.width > imageSize.height) {
        size = CGSizeMake(size.height, size.width);
    }
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (NSData *)compressImageBelow:(NSInteger)length{
    
    NSData *data11 = UIImageJPEGRepresentation(self, 1);
    double i = 15;
    while (data11.length > length) {
        i = i  * 2.0 / 3.0;
        data11 = UIImageJPEGRepresentation(self, i / 10.0);
        NSLog(@"%ld",data11.length);
        if (i < 1) {
            i = 0;
            data11 = UIImageJPEGRepresentation(self, i);
            break;
        }
    }
    return data11;
}

- (UIImage *)squareImage{
    CGImageRef squrareImageRef;
    if (self.size.width < self.size.height) {
        squrareImageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(0, 0, self.size.width, self.size.width));
    }
    else{
        squrareImageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake( (self.size.width - self.size.height)/2.0, 0, self.size.height, self.size.height));
    }
    UIImage *squrareImage = [UIImage imageWithCGImage:squrareImageRef];
    CGImageRelease(squrareImageRef);
    
    return squrareImage;
}


@end
