//
//  AETestViewController7.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/19.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AETestViewController7.h"
#import "AxcBufferView.h"

@interface AETestViewController7 ()<EZAudioPlayerDelegate>

// 音频文件
@property(nonatomic , strong)EZAudioFile *audioFile;
// 播放器
@property(nonatomic , strong)EZAudioPlayer *player;

@property(nonatomic , strong)AxcBufferView *bufferView;
@end

@implementation AETestViewController7

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.bufferView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(200);
    }];
    
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
        
        [self.bufferView updateBuffer:buffer[0] withBufferSize:bufferSize];
        
    });
    
}

- (AxcBufferView *)bufferView{
    if (!_bufferView) {
        _bufferView = [AxcBufferView new];
        [self.view addSubview:_bufferView];
    }
    return _bufferView;
}
- (EZAudioFile *)audioFile{
    if (!_audioFile) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Blue" ofType:@"wav"];
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
