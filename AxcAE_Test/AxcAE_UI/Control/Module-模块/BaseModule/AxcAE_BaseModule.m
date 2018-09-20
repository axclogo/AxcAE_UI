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
    self.migrationRate = 100.f;
    self.offsetMultiple = 0.1f;
    self.compensationCoefficient = 0.5f;
}
- (void)startAnimation{}


- (void)setGyroscope:(AxcAE_Gyroscope)gyroscope{
    _gyroscope = gyroscope;
    [self offsetWithGyroscope:gyroscope];
}
- (void)offsetWithGyroscope:(AxcAE_Gyroscope)gyroscope{}

@end
