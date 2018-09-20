//
//  AxcAE_ImageBaseObj.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_ImageBaseObj.h"

@implementation AxcAE_ImageBaseObj

#pragma mark - 懒加载
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

@end
