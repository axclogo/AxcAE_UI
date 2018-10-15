
//
//  AETestViewController4.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/13.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AETestViewController4.h"
#import <ZLHistogramAudioPlot.h>
#import <EZAudio.h>

@interface AETestViewController4 ()<EZAudioPlayerDelegate>

// 音频文件
@property(nonatomic , strong)EZAudioFile *audioFile;
// 播放器
@property(nonatomic , strong)EZAudioPlayer *player;
// 频谱仪
@property(nonatomic , strong)ZLHistogramAudioPlot *audioPlot;


@end

@implementation AETestViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
//    AVPlayer *player = [[AVPlayer alloc]initWithPlayerItem:songItem];

    [self.view addSubview:self.audioPlot];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.player setAudioFile:self.audioFile];
    [self.player play];
}
- (void)  audioPlayer:(EZAudioPlayer *)audioPlayer
          playedAudio:(float **)buffer
       withBufferSize:(UInt32)bufferSize
 withNumberOfChannels:(UInt32)numberOfChannels
          inAudioFile:(EZAudioFile *)audioFile{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.audioPlot updateBuffer:buffer[0] withBufferSize:bufferSize];
        
    });
    
}

#pragma mark - 输出代理

#pragma mark - 懒加载
- (ZLHistogramAudioPlot *)audioPlot{
    if (!_audioPlot) {
        _audioPlot = [[ZLHistogramAudioPlot alloc] initWithFrame:CGRectMake(10, 100, 400, 500)];
        _audioPlot.backgroundColor =
        [UIColor colorWithRed:0.984 green:0.71 blue:0.365 alpha:1];
        _audioPlot.plotType = EZPlotTypeBuffer;
        _audioPlot.shouldFill = YES;
        _audioPlot.shouldMirror = YES;
        
        NSArray *murmurColors = @[
                              [UIColor colorWithRed:242 / 255.0
                                              green:128 / 255.0
                                               blue:78 / 255.0
                                              alpha:1],
                              [UIColor colorWithRed:40 / 255.0
                                              green:56 / 255.0
                                               blue:72 / 255.0
                                              alpha:1],
                              [UIColor colorWithRed:244 / 255.0
                                              green:234 / 255.0
                                               blue:119 / 255.0
                                              alpha:1],
                              [UIColor colorWithRed:255 / 255.0
                                              green:197 / 255.0
                                               blue:69 / 255.0
                                              alpha:1],
                              [UIColor colorWithRed:193 / 255.0
                                              green:75 / 255.0
                                               blue:43 / 255.0
                                              alpha:1],
                              [UIColor colorWithRed:40 / 255.0
                                              green:181 / 255.0
                                               blue:164 / 255.0
                                              alpha:1],
                              [UIColor colorWithRed:208 / 255.0
                                              green:221 / 255.0
                                               blue:38 / 255.0
                                              alpha:1],
                              ];
        
        
        _audioPlot.colors = murmurColors;
        _audioPlot.color = [UIColor colorWithWhite:0.598 alpha:1.000];
//        _audioPlot.numOfBins = 60;
//        _audioPlot.padding = 1;

//        [self.view addSubview:_audioPlot];
    }
    return _audioPlot;
}
- (EZAudioFile *)audioFile{
    if (!_audioFile) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Heaven" ofType:@"wav"];
        NSURL *fileUrl = [NSURL fileURLWithPath:path];
        _audioFile = [EZAudioFile audioFileWithURL:fileUrl];
    }
    return _audioFile;
}
- (EZAudioPlayer *)player{
    if (!_player) {
        _player = [[EZAudioPlayer alloc] initWithDelegate:self];
    }
    return _player;
}


@end
