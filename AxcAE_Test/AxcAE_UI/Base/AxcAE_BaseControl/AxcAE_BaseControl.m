//
//  AxcAE_BaseControl.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/14.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseControl.h"

@implementation AxcAE_BaseControl

#pragma mark - init&ParentClass
- (instancetype)init{
    self = [super init];
    if (self) [self AxcAE_BaseConfiguration];
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) [self AxcAE_BaseConfiguration];
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) [self AxcAE_BaseConfiguration];
    return self;
}
#pragma mark - 子类公用

#pragma mark - 子类扩展
- (void)AxcAE_BaseConfiguration{
    self.tintColor = AxcAE_AcienceTechnologyBlue;
}

@end
