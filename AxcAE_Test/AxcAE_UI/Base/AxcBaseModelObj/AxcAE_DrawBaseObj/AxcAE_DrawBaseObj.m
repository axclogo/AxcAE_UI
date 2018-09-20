//
//  AxcAE_DrawBaseObj.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_DrawBaseObj.h"

@implementation AxcAE_DrawBaseObj


- (CALayer *)layer{
    if (!_layer) {
        _layer = [[CALayer alloc] init];
    }
    return _layer;
}

@end
