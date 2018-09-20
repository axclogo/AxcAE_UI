//
//  AxcAE_ParallelogramView.m
//  Axc_AEUI
//
//  Created by Axc on 2018/6/9.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_ParallelogramView.h"

@interface AxcAE_ParallelogramView ()

@property(nonatomic, strong)CAShapeLayer *lineLayer;

@property(nonatomic, strong)NSArray <NSArray *>*shortPathArray;

@end

@implementation AxcAE_ParallelogramView

//- (void)AxcAE_BaseConfiguration{
//    [super AxcAE_BaseConfiguration];
//    self.shortLength = 10;
//}
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    self.shortPathArray =
//    @[@[[NSValue valueWithCGPoint: CGPointMake(0,0)],
//        [NSValue valueWithCGPoint: CGPointMake(self.axcAE_Width + self.shortLength,0)],
//        [NSValue valueWithCGPoint: CGPointMake(self.axcAE_Width , self.axcAE_Height)],
//        [NSValue valueWithCGPoint: CGPointMake(-self.shortLength,self.axcAE_Height)],
//        [NSValue valueWithCGPoint: CGPointMake(0,0)]],
//      @[[NSValue valueWithCGPoint: CGPointMake(self.shortLength,0)],
//        [NSValue valueWithCGPoint: CGPointMake(self.axcAE_Width,0)],
//        [NSValue valueWithCGPoint: CGPointMake(self.axcAE_Width - self.shortLength, self.axcAE_Height)],
//        [NSValue valueWithCGPoint: CGPointMake(0,self.axcAE_Height)],
//        [NSValue valueWithCGPoint: CGPointMake(self.shortLength,0)]]];
//    NSArray *points = self.shortLength > 0 ? self.shortPathArray.lastObject : self.shortPathArray.firstObject;
//    self.lineLayer.path = [self AxcAE_BaseSettingLineArray:points].CGPath;
//}
//- (void)drawTime:(CGFloat)time{
//    [self AxcAE_BaseDrawLineWithLayer:self.lineLayer time:time];
//}
//
//- (NSArray<NSArray *> *)shortPathArray{
//    if (!_shortPathArray) {
//        _shortPathArray = @[].copy;
//
//    }
//    return _shortPathArray;
//}
//
//- (CAShapeLayer *)lineLayer{
//    if (!_lineLayer) {
//        _lineLayer = [CAShapeLayer layer];
//        _lineLayer.fillColor = self.tintColor.CGColor;//填充颜色
//        _lineLayer.strokeColor = self.tintColor.CGColor;     //边框颜色
//    }
//    return _lineLayer;
//}

@end
