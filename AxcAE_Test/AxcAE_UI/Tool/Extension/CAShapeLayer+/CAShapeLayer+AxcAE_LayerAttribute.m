//
//  CAShapeLayer+AxcAE_LayerAttribute.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "CAShapeLayer+AxcAE_LayerAttribute.h"
#import <objc/runtime.h>

static NSString * const kdrawPath = @"drawPath";
static NSString * const ktag = @"tag";

@implementation CAShapeLayer (AxcAE_LayerAttribute)

- (void)setDrawPath:(UIBezierPath *)drawPath{
    [self willChangeValueForKey:kdrawPath];
    objc_setAssociatedObject(self, &kdrawPath,
                             drawPath,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kdrawPath];
}
- (UIBezierPath *)drawPath{
    return objc_getAssociatedObject(self, &kdrawPath);
}

- (void)setTag:(NSInteger)tag{
    [self willChangeValueForKey:ktag];
    objc_setAssociatedObject(self, &ktag,
                             @(tag),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:ktag];
}
- (NSInteger )tag{
    NSNumber *num = objc_getAssociatedObject(self, &ktag);
    return num.integerValue;
}

@end
