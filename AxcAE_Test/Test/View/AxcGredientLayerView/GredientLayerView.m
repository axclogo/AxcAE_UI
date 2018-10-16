//
//  GredientLayerView.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/15.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "GredientLayerView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式

static const float kPROGRESS_LINE_WIDTH=4.0;

@interface GredientLayerView ()

@property (nonatomic,strong) CAShapeLayer *progressLayer;

@end

@implementation GredientLayerView

- (instancetype)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //设置贝塞尔曲线
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:(frame.size.width-kPROGRESS_LINE_WIDTH)/2 startAngle:degreesToRadians(-210) endAngle:degreesToRadians(180) clockwise:YES];
        
        //遮罩层
        
        _progressLayer = [CAShapeLayer layer];
        
        _progressLayer.frame = self.bounds;
        
        _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
        
        _progressLayer.strokeColor=[UIColor redColor].CGColor;
        
        _progressLayer.lineCap = kCALineCapRound;
        
        _progressLayer.lineWidth = kPROGRESS_LINE_WIDTH;
        
        //渐变图层
        
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        
        gradientLayer.frame = _progressLayer.frame;
        
        [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[[UIColor yellowColor] CGColor],(id)[[UIColor blueColor] CGColor], nil]];
        
        [gradientLayer setLocations:@[@0,@0.6,@1]];
        
        [gradientLayer setStartPoint:CGPointMake(0, 0)];
        
        [gradientLayer setEndPoint:CGPointMake(1, 0)];
        
        //用progressLayer来截取渐变层 遮罩
        
        [gradientLayer setMask:_progressLayer];
        
        [self.layer addSublayer:gradientLayer];
        
        //增加动画
        
        CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        
        pathAnimation.duration = 2;
        
        pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
        
        pathAnimation.toValue=[NSNumber numberWithFloat:1.0f];
        
        pathAnimation.autoreverses=NO;
        
        _progressLayer.path=path.CGPath;
        
        [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
    }
    
    return self;
    
}

@end
