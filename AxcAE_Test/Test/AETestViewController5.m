//
//  AETestViewController5.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/15.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AETestViewController5.h"

#import "AxcDrawPath.h"

#import <AVFoundation/AVFoundation.h>

@interface AETestViewController5 ()

@property(nonatomic , strong)CAShapeLayer *layer;

@property(nonatomic , strong)AVAudioPlayer *player;

@property(nonatomic , strong)NSTimer *timer;

@property(nonatomic , strong)NSMutableArray *arr_M;

@end

@implementation AETestViewController5

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.layer = [CAShapeLayer new];
    self.layer.frame = CGRectMake(100, 200, 300, 400);
    [self.view.layer addSublayer:self.layer];
    
    
    
    self.layer.lineWidth = 2;
    self.layer.strokeColor = KScienceTechnologyBlue.CGColor;
    self.layer.lineDashPattern = @[@(2),@(1)];
    
    //创建CGContextRef
    UIGraphicsBeginImageContext(CGSizeMake(300, 300));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    
    //绘制Path
    CGFloat point = 300;
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, point, 0);
    CGPathAddLineToPoint(path, NULL, point, point);
    CGPathAddLineToPoint(path, NULL, 0, point);
    CGPathCloseSubpath(path);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 0.25,0.5,0.75,1.0};
    
    NSArray *colors = @[(__bridge id) [UIColor greenColor].CGColor,
                        (__bridge id) [UIColor redColor].CGColor,
                        (__bridge id) [UIColor blackColor].CGColor,
                        (__bridge id) [UIColor blueColor].CGColor,
                        (__bridge id) [UIColor brownColor].CGColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGPoint center = CGPointMake(point/2, point/2);
    CGFloat radius = point ;
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CGRectMake(10, 100, 300, 300);
    imgView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:imgView];

    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//
//    gradientLayer.frame = [UIScreen mainScreen].bounds;
//
//    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[[UIColor yellowColor] CGColor],(id)[[UIColor blueColor] CGColor], nil]];
//
//    [gradientLayer setLocations:@[@0,@0.6,@1]];
//
//    [gradientLayer setStartPoint:CGPointMake(0, 0)];
//
//    [gradientLayer setEndPoint:CGPointMake(1, 0)];
//
//    //用progressLayer来截取渐变层 遮罩
//
//    self.layer.fillColor = [[UIColor clearColor] CGColor];

    imgView.layer.frame = [UIScreen mainScreen].bounds;
    imgView.layer.mask = self.layer;
    [self.view.layer addSublayer:imgView.layer];
    
}
- (void)setHeight:(CGFloat )height{
    if (self.arr_M.count > 100) {
        [self.arr_M removeLastObject];
    }
    [self.arr_M insertObject:@(height*200) atIndex:0];
    
    CGPoint center = CGPointMake(100, 200);
    UIBezierPath *bb = [UIBezierPath new];;
    bb = [AxcDrawPath AxcDrawCircularRadiationCenter:center
                                              radius:100
                                         lineHeights:self.arr_M
                                             outside:NO
                                          startAngle:-90
                                        openingAngle:0
                                           clockwise:NO];
    [bb appendPath: [AxcDrawPath AxcDrawCircularRadiationCenter:center
                                                         radius:103
                                                    lineHeights:self.arr_M
                                                        outside:YES
                                                     startAngle:90
                                                   openingAngle:0
                                                      clockwise:YES]];
    self.layer.path = bb.CGPath;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.player play];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)timerAction{
    [_player updateMeters];
    
    
    float peakPower = [self.player averagePowerForChannel:0];//分贝
    double peakPowerForChannel = pow(10, (0.05 * peakPower));//波形幅度

    
    [self setHeight:peakPowerForChannel];
    
}


#pragma mark - player
- (AVAudioPlayer *)player{
    if (!_player) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Blue" ofType:@"wav"];
        NSURL *fileUrl = [NSURL fileURLWithPath:path];
        _player  = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
        _player.meteringEnabled = YES;
    }
    return _player;
}

- (NSMutableArray *)arr_M{
    if (!_arr_M) {
        _arr_M = @[].mutableCopy;
    }
    return _arr_M;
}


@end
