//
//  AxcAE_BaseDrawModule.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseDrawModule.h"

@implementation AxcAE_BaseDrawModule

/** 给Image重绘颜色 */
- (UIImage *)AxcAE_BaseSettingTintColorWithObj:(AxcAE_BaseObject *)obj{
    UIGraphicsBeginImageContextWithOptions(obj.image.size, NO, obj.image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, obj.image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, obj.image.size.width, obj.image.size.height);
    CGContextClipToMask(context, rect, obj.image.CGImage);
    [obj.tintColor setFill];
    CGContextFillRect(context, rect);
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
