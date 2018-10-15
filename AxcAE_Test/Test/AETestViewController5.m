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
}
- (void)setHeight:(CGFloat )height{
    if (self.arr_M.count > 100) {
        [self.arr_M removeLastObject];
    }
    [self.arr_M insertObject:@(height*100) atIndex:0];
    
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
