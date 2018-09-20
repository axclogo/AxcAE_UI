//
//  AxcAE_BaseModule.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_BaseModule.h"

@implementation AxcAE_BaseModule

-(void)AxcAE_BaseConfiguration{
    [super AxcAE_BaseConfiguration];
    self.verticalDrawPoints = AxcAE_Ring_VerticalDrawPointsCenter;
    self.horizontalDrawPoints = AxcAE_Ring_HorizontalDrawPointsCenter;
}

- (void)startAnimation{}

@end
