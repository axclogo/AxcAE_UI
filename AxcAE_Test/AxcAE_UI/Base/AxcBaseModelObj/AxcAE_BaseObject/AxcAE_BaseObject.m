//
//  AxcAE_BaseObject.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/17.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseObject.h"

@implementation AxcAE_BaseObject

- (instancetype)init{
    self = [super init];
    if (self) {
        [self AxcAE_BaseConfiguration];
    }
    return self;
}

- (void)AxcAE_BaseConfiguration{
    self.distance = 10.f;
}



@end
