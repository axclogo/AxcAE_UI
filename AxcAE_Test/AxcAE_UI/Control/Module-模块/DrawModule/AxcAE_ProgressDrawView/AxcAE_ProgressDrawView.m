//
//  AxcAE_ProgressDrawView.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/21.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_ProgressDrawView.h"

@interface AxcAE_ProgressDrawView()

@end

@implementation AxcAE_ProgressDrawView

- (instancetype)initWithStyle:(AxcAE_ProgressDrawStyle )style{
    if (self == [super init]) {
        self.style = style;
    }
    return self;
}

- (void)AxcAE_BaseConfiguration{
    [super AxcAE_BaseConfiguration];
    self.proportion = 0.f;
    self.style = AxcAE_ProgressDrawStyleRoundedVitro;
    self.drawDirection = AxcAE_ProgressDrawDirectionBottom;
    self.contentSpacing = 3.0f;
    self.gridHeight = 5.0f;
    self.gridBorderWidth = 0.5f;
    self.gridSpacing = 2.0f;
    self.gridBorderColor = [UIColor whiteColor];
    self.gridFillColor = self.tintColor;
    self.headerHeight = 10.f;
    self.batteryHeaderSpacing = 10.f;
    self.thermometerBodyWidth = 10.f;
    self.dialGaugeSpacing = 3.f;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!self.axcAE_Width) return;
    [self layoutProgressLayer];
    __weak typeof(self)weakSelf = self;
    if ([self.delegate respondsToSelector:@selector(contentAreaWithProgressDrawView:)]) {
        self.contentLayer.frame = [self.delegate contentAreaWithProgressDrawView:weakSelf];
    }else{
        self.contentLayer.frame = self.bounds;
    }
    switch (self.style) {
        case AxcAE_ProgressDrawStyleRoundedVitro:{ // 试管类型
            [weakSelf settingVitroStyleRadius:YES];
        }break;
        case AxcAE_ProgressDrawStyleRectangleVitro:{ // 矩形类型
            [weakSelf settingVitroStyleRadius:NO];
        }break;
        case AxcAE_ProgressDrawStyleExpectRectangleHead:{ // 方角头预期型
            [weakSelf settingExpectRectangleHeadStyle:YES];
        }break;
        case AxcAE_ProgressDrawStyleExpectFlatHead:{ // 平角头预期型
            [weakSelf settingExpectRectangleHeadStyle:NO];
        }break;
        case AxcAE_ProgressDrawStyleRoundedBattery:{ // 圆角电池型
            [weakSelf settingBatteryStyleRounded:YES];
        }break;
        case AxcAE_ProgressDrawStyleRectangleBattery:{ // 方角电池型
            [weakSelf settingBatteryStyleRounded:NO];
        }break;
        case AxcAE_ProgressDrawStyleThermometer:{ // 温度计型
            [weakSelf settingThermometerStyle];
        }break;
        case AxcAE_ProgressDrawStyleDialGauge:{ // 刻度计型
            [weakSelf settingDialGaugeStyle];
        }break;
            
        default: break;
    }
}

#pragma mark - 设置外观
#pragma mark 刻度计
- (void)settingDialGaugeStyle{
    self.dialGaugeLayer.frame = self.bounds;
    // 绘制刻度
    NSInteger count = self.axcAE_Height/self.dialGaugeSpacing;
    NSMutableArray *points = @[].mutableCopy;
    for (int i = 0; i < count;  i ++) {
        [points addObject:[NSValue valueWithCGPoint:CGPointMake(0, self.dialGaugeSpacing * i)]];
        [points addObject:[NSValue valueWithCGPoint:CGPointMake(self.axcAE_Width, self.dialGaugeSpacing * i)]];
        [points addObject:[NSNull null]];
    }
    self.dialGaugeLayer.path = [AxcDrawPath AxcDrawLineArray:points].CGPath;
    [self drawGridContentSpacing];
}
#pragma mark 温度计
- (void)settingThermometerStyle{
    self.thermometerLayer.frame = self.thermometerMaskLayer.frame = self.bounds;
    // 绘制遮罩外壳
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGFloat topRadius = self.thermometerBodyWidth/2;
    [bezierPath addArcWithCenter:CGPointMake(self.axcAE_Width/2, self.axcAE_Height - topRadius)
                          radius:topRadius
                      startAngle:0
                        endAngle:M_PI
                       clockwise:YES];
    CGFloat thermometerBodyRadius = self.axcAE_Width/2;
    [bezierPath addArcWithCenter:CGPointMake(self.axcAE_Width/2, thermometerBodyRadius)
                  radius:thermometerBodyRadius
              startAngle:AxcAE_Angle(90.f) + sinf((self.thermometerBodyWidth/2)/thermometerBodyRadius)
                endAngle:AxcAE_Angle(90.f) - sinf((self.thermometerBodyWidth/2)/thermometerBodyRadius)
               clockwise:YES];
    [bezierPath closePath];
    self.thermometerLayer.path = self.thermometerMaskLayer.path = bezierPath.CGPath;
    [self drawGridContentSpacing];
}

#pragma mark 电池
- (void)settingBatteryStyleRounded:(BOOL )rounded{
    __weak typeof(self)weakSelf = self; // 还得再计算一遍、、
    if ([self.delegate respondsToSelector:@selector(contentAreaWithProgressDrawView:)]) {
        self.contentLayer.frame = [self.delegate contentAreaWithProgressDrawView:weakSelf];
    }else{
        if (rounded) { // 是否为圆角
            self.contentLayer.frame = CGRectMake(0, self.headerHeight + self.axcAE_Width/2,
                                                 self.axcAE_Width, self.axcAE_Height - 2*(self.headerHeight+self.axcAE_Width/2));
        }else{
            self.contentLayer.frame = CGRectMake(0, self.headerHeight, self.axcAE_Width, self.axcAE_Height - 2*self.headerHeight);
        }
    }
    self.batteryLayer.frame = self.bounds;
    self.layer.borderWidth = 0;
    self.layer.borderColor = nil;
    // 先描边
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    if (rounded) {
        CGFloat radius = self.axcAE_Width/2;
        CGFloat Y = radius + self.headerHeight;
        [bezierPath addArcWithCenter:CGPointMake(radius, Y) radius:radius startAngle:0 endAngle:M_PI clockwise:NO];
        [bezierPath addLineToPoint:CGPointMake(0, Y)];
        [bezierPath addLineToPoint:CGPointMake(0, self.axcAE_Height - Y)];
        [bezierPath addArcWithCenter:CGPointMake(radius, self.axcAE_Height - Y) radius:radius startAngle:M_PI endAngle:0 clockwise:NO];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width, self.axcAE_Height - Y)];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width, Y)];
        // 电池头
        CGFloat shot = radius - self.batteryHeaderSpacing;
        CGFloat shotArc = Y - sqrt(radius*radius - shot*shot); // 短边Y值开根号勾股算
        [bezierPath moveToPoint:CGPointMake(self.batteryHeaderSpacing, shotArc)];
        [bezierPath addLineToPoint:CGPointMake(self.batteryHeaderSpacing, 0)];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width - self.batteryHeaderSpacing, 0)];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width - self.batteryHeaderSpacing, shotArc)];
        // 另一边电池头
        [bezierPath moveToPoint:CGPointMake(self.batteryHeaderSpacing, self.axcAE_Height - shotArc)];
        [bezierPath addLineToPoint:CGPointMake(self.batteryHeaderSpacing, self.axcAE_Height)];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width - self.batteryHeaderSpacing, self.axcAE_Height)];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width - self.batteryHeaderSpacing, self.axcAE_Height - shotArc)];
    }else{
        [bezierPath moveToPoint:CGPointMake(0, self.headerHeight)];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width, self.headerHeight)];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width, self.axcAE_Height - self.headerHeight)];
        [bezierPath addLineToPoint:CGPointMake(0, self.axcAE_Height - self.headerHeight)];
        [bezierPath addLineToPoint:CGPointMake(0, self.headerHeight)]; // 闭合
        // 电池头
        [bezierPath moveToPoint:CGPointMake(self.batteryHeaderSpacing, self.headerHeight)];
        [bezierPath addLineToPoint:CGPointMake(self.batteryHeaderSpacing, 0)];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width - self.batteryHeaderSpacing, 0)];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width - self.batteryHeaderSpacing, self.headerHeight)];
        // 另一边
        [bezierPath moveToPoint:CGPointMake(self.batteryHeaderSpacing, self.axcAE_Height - self.headerHeight)];
        [bezierPath addLineToPoint:CGPointMake(self.batteryHeaderSpacing, self.axcAE_Height)];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width - self.batteryHeaderSpacing, self.axcAE_Height)];
        [bezierPath addLineToPoint:CGPointMake(self.axcAE_Width - self.batteryHeaderSpacing, self.axcAE_Height - self.headerHeight)];
    }
    self.batteryLayer.path = bezierPath.CGPath;
    [self drawGridContentSpacing];
}
#pragma mark 预计型
- (void)settingExpectRectangleHeadStyle:(BOOL )isRectangleHead{
    // 设置Frame
    self.rectangleLayer.frame = self.bounds;
    self.layer.borderWidth = 0;
    self.layer.borderColor = nil;
    // 绘制头部矩形
    CGFloat X = (self.axcAE_Width - self.headerHeight)/2;
    NSMutableArray *points = @[].mutableCopy;
    [points addObject: [NSValue valueWithCGPoint:CGPointMake(X, self.axcAE_Height)]];
    [points addObject: [NSValue valueWithCGPoint:CGPointMake(X + self.headerHeight, self.axcAE_Height)]];
    if (isRectangleHead) {
        [points addObject: [NSValue valueWithCGPoint:CGPointMake(X + self.headerHeight, self.axcAE_Height - self.headerHeight)]];
        [points addObject: [NSValue valueWithCGPoint:CGPointMake(X, self.axcAE_Height - self.headerHeight)]];
        [points addObject: [NSValue valueWithCGPoint:CGPointMake(X, self.axcAE_Height)]];
    }
    [points addObject: [NSNull null]];
    [points addObject: [NSValue valueWithCGPoint:CGPointMake(self.axcAE_Width/2, self.axcAE_Height - (isRectangleHead ? self.headerHeight : 0))]];
    [points addObject: [NSValue valueWithCGPoint:CGPointMake(self.axcAE_Width/2, 0)]];
    [points addObject: [NSNull null]];
    [points addObject: [NSValue valueWithCGPoint:CGPointMake(X, 0)]];
    [points addObject: [NSValue valueWithCGPoint:CGPointMake(X + self.headerHeight, 0)]];
    self.rectangleLayer.path = [AxcDrawPath AxcDrawLineArray:points].CGPath;
    [self drawGridContentSpacing];
}
#pragma mark 试管
// 试管
- (void)settingVitroStyleRadius:(BOOL )radius{
    if (radius) { // 圆角
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.axcAE_Width/2;
    } // 外框
    self.layer.borderWidth = 1;
    [self drawGridContentSpacing];
}

#pragma mark - SET
- (void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    self.layer.borderColor = tintColor.CGColor; // 这里SET函数可以优化
    self.rectangleLayer.strokeColor = tintColor.CGColor;
    self.batteryLayer.strokeColor = tintColor.CGColor;
    self.thermometerLayer.strokeColor = tintColor.CGColor;
    self.dialGaugeLayer.strokeColor = tintColor.CGColor;
}
- (void)setStyle:(AxcAE_ProgressDrawStyle)style{
    _style = style;
    [self layoutSubviews]; // 重新计算布局
}
- (void)setProportion:(CGFloat)proportion{
    _proportion = proportion; // 重新设置进度
    [self layoutProgressLayer];
}
- (void)setGridBorderColor:(UIColor *)gridBorderColor{
    _gridBorderColor = gridBorderColor;
    self.progressLayer.strokeColor = _gridBorderColor.CGColor;
}
- (void)setGridFillColor:(UIColor *)gridFillColor{
    _gridFillColor = gridFillColor;
    self.progressLayer.fillColor = _gridFillColor.CGColor; // 填充色
}
- (void)setGridBorderWidth:(CGFloat)gridBorderWidth{
    _gridBorderWidth = gridBorderWidth;
    self.progressLayer.lineWidth = _gridBorderWidth;
}
- (void)setGridLineDashPattern:(NSArray <NSNumber *>*)gridLineDashPattern{
    _gridLineDashPattern = gridLineDashPattern;
    if (_gridLineDashPattern.count) self.progressLayer.lineDashPattern = _gridLineDashPattern;
}
- (void)setContentSpacing:(CGFloat)contentSpacing{
    _contentSpacing = contentSpacing;
    [self layoutProgressLayer];
}
- (void)setDrawDirection:(AxcAE_ProgressDrawDirection)drawDirection{
    _drawDirection = drawDirection;
    if (self.drawDirection != AxcAE_ProgressDrawDirectionTop) {
        self.layer.transform =  CATransform3DMakeRotation(M_PI, 0, 0, 1);
    }
}
- (void)setHeaderHeight:(CGFloat)headerHeight{
    _headerHeight = headerHeight;
    [self layoutSubviews];
}
- (void)setBatteryHeaderSpacing:(CGFloat)batteryHeaderSpacing{
    _batteryHeaderSpacing = batteryHeaderSpacing;
    [self layoutSubviews];
}
- (void)layoutProgressLayer{
    self.progressLayer.frame = CGRectMake(self.contentSpacing, 0,
                                         self.bounds.size.width - 2 * self.contentSpacing,
                                         self.axcAE_Height * self.proportion - 2*self.contentSpacing);
}


- (void)drawGridContentSpacing{
    // 计算网格个数
    if (self.proportion > 1) self.proportion = 1.0f; // 阈值限制
    if (self.proportion < 0) self.proportion = 0.0f; // 阈值限制
    CGFloat gridCount = self.axcAE_Height / self.gridHeight;
    NSMutableArray *drawPath = @[].mutableCopy;
    if (self.gridSpacing != 0){
        for (int i = 0; i < gridCount; i ++) {
            CGFloat changeY = i * (self.gridHeight + self.gridSpacing);
            [drawPath addObject:[NSValue valueWithCGPoint:
                                CGPointMake(0, self.axcAE_Height - changeY)]]; // 左下角
            [drawPath addObject:[NSValue valueWithCGPoint:
                                CGPointMake(self.axcAE_Width - 2*self.contentSpacing, self.axcAE_Height - changeY)]]; // 右下角
            [drawPath addObject:[NSValue valueWithCGPoint:
                                CGPointMake(self.axcAE_Width - 2*self.contentSpacing, self.axcAE_Height - self.gridHeight - changeY)]]; // 右上角
            [drawPath addObject:[NSValue valueWithCGPoint:
                                CGPointMake(0, self.axcAE_Height - self.gridHeight - changeY)]]; // 左上角
            [drawPath addObject:[NSValue valueWithCGPoint:
                                CGPointMake(0, self.axcAE_Height - changeY)]]; // 左下角
            [drawPath addObject:[NSNull null]]; // 使其触发闭合函数
        }
    }else{ // 全填充
        [drawPath addObject:[NSValue valueWithCGPoint:
                            CGPointMake(0, self.axcAE_Height - 2*self.contentSpacing)]]; // 左下角
        [drawPath addObject:[NSValue valueWithCGPoint:
                            CGPointMake(self.axcAE_Width - 2*self.contentSpacing, self.axcAE_Height - 2*self.contentSpacing)]]; // 右下角
        [drawPath addObject:[NSValue valueWithCGPoint:
                            CGPointMake(self.axcAE_Width - 2*self.contentSpacing, 0)]]; // 右上角
        [drawPath addObject:[NSValue valueWithCGPoint:
                            CGPointMake(0, 0)]]; // 左上角
        [drawPath addObject:[NSValue valueWithCGPoint:
                            CGPointMake(0, self.axcAE_Height - 2*self.contentSpacing)]]; // 左下角
        [drawPath addObject:[NSNull null]]; // 使其触发闭合函数
    }
    self.progressLayer.path = [AxcDrawPath AxcDrawLineArray:drawPath].CGPath;
}
#pragma mark - 懒加载
- (CAShapeLayer *)dialGaugeLayer{
    if (!_dialGaugeLayer) {
        _dialGaugeLayer = [CAShapeLayer layer];
        [self settingLayer:_dialGaugeLayer];
        _dialGaugeLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_dialGaugeLayer];
    }
    return _dialGaugeLayer;
}

- (CAShapeLayer *)thermometerLayer{
    if (!_thermometerLayer) {
        _thermometerLayer = [CAShapeLayer layer];
        [self settingLayer:_thermometerLayer];
        _batteryLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_thermometerLayer];
    }
    return _thermometerLayer;
}

- (CAShapeLayer *)thermometerMaskLayer{
    if (!_thermometerMaskLayer) {
        _thermometerMaskLayer = [CAShapeLayer layer];
        [self settingLayer:_thermometerMaskLayer];
        self.layer.mask = _thermometerMaskLayer;
    }
    return _thermometerMaskLayer;
}

- (CAShapeLayer *)batteryLayer{
    if (!_batteryLayer) {
        _batteryLayer = [[CAShapeLayer alloc] init];
        [self settingLayer:_batteryLayer];
        _batteryLayer.lineWidth = 1.f;
        _batteryLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_batteryLayer];
    }
    return _batteryLayer;
}

- (CAShapeLayer *)rectangleLayer{
    if (!_rectangleLayer) {
        _rectangleLayer = [[CAShapeLayer alloc] init];
        [self settingLayer:_rectangleLayer];
        _rectangleLayer.lineWidth = 1.f;
        _rectangleLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_rectangleLayer];
    }
    return _rectangleLayer;
}

- (CAShapeLayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [[CAShapeLayer alloc] init];
        [self settingLayer:_progressLayer];
        [self.contentLayer addSublayer:_progressLayer];
    }
    return _progressLayer;
}

- (CAShapeLayer *)contentLayer{
    if (!_contentLayer) {
        _contentLayer = [[CAShapeLayer alloc] init];
        [self settingLayer:_contentLayer];
        [self.layer addSublayer:_contentLayer];
    }
    return _contentLayer;
}

- (void)settingLayer:(CAShapeLayer *)layer{
    layer.anchorPoint = CGPointZero; // 无锚点
    layer.masksToBounds = YES; // 多余部分不展示
}

@end
