//
//  AxcBufferView.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/19.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcBufferView.h"

const UInt32 kAxcMaxFrames = 2048;
const Float32 kAxcAdjust0DB = 1.5849e-13;
const float kAxcTimerDelay = 1/60.0; //Alter this to draw more or less often

@interface AxcBufferView (){
    // ftt setup
    FFTSetup fftSetup;
    COMPLEX_SPLIT A;
    int log2n, n, nOver2;
    float sampleRate, *dataBuffer;
    size_t bufferCapacity, index;
    float *heightsByFrequency, *speeds, *times, *tSqrts, *vts, *deltaHeights;

}

@property(nonatomic , strong)NSMutableArray *heightsByTime;

@property(nonatomic , strong)CAShapeLayer *bzLayer;

@end

#define  knum 100

@implementation AxcBufferView

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.maxFrequency = 10000;
        self.minFrequency = 1200;
//        self.numOfBins = 30;
//        self.padding = 1/10.0;
        self.gain = 10;
        self.gravity = 10*kAxcTimerDelay;
        
        
        // ftt setup
        dataBuffer = (float*)malloc(kAxcMaxFrames * sizeof(float));
        log2n = log2f(kAxcMaxFrames);
        n = 1 << log2n;
        assert(n == kAxcMaxFrames);
        nOver2 = kAxcMaxFrames/2;
        bufferCapacity = kAxcMaxFrames;
        index = 0;
        A.realp = (float *)malloc(nOver2 * sizeof(float));
        A.imagp = (float *)malloc(nOver2 * sizeof(float));
        fftSetup = vDSP_create_fftsetup(log2n, FFT_RADIX2);
        
        
        // Configure audio session
        AVAudioSession *session = [AVAudioSession sharedInstance];
        sampleRate = session.sampleRate;
        
        heightsByFrequency = (float *)calloc(sizeof(float), knum);

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bzLayer.frame = self.bounds;
}

- (void)updateBuffer:(float *)buffer withBufferSize:(UInt32)bufferSize {
    [self setSampleData:buffer length:bufferSize];
}

#pragma mark - Update Buffers
- (void)setSampleData:(float *)data
               length:(int)length {
    NSMutableArray *Arr_M = @[].mutableCopy;

    // 用采样数据填充缓冲区。如果我们填满缓冲区，运行fft。
    int inNumberFrames = length;
    int read = (int)(bufferCapacity - index);
    if (read > inNumberFrames) {
        memcpy((float *)dataBuffer + index, data, inNumberFrames*sizeof(float));
        index += inNumberFrames;
    } else {
        // If we enter this conditional, our buffer will be filled and we should perform the FFT.
        memcpy((float *)dataBuffer + index, data, read*sizeof(float));
        
        // Reset the index.
        index = 0;
        
        // fft
        vDSP_ctoz((COMPLEX*)dataBuffer, 2, &A, 1, nOver2);
        vDSP_fft_zrip(fftSetup, &A, 1, log2n, FFT_FORWARD);
        vDSP_ztoc(&A, 1, (COMPLEX *)dataBuffer, 2, nOver2);
        
        // convert to dB
        Float32 one = 1, zero = 0;
        vDSP_vsq(dataBuffer, 1, dataBuffer, 1, inNumberFrames);
        vDSP_vsadd(dataBuffer, 1, &kAxcAdjust0DB, dataBuffer, 1, inNumberFrames);
        vDSP_vdbcon(dataBuffer, 1, &one, dataBuffer, 1, inNumberFrames, 0);
        vDSP_vthr(dataBuffer, 1, &zero, dataBuffer, 1, inNumberFrames);
        
        float mul = (sampleRate/bufferCapacity)/2;
        int minFrequencyIndex = self.minFrequency/mul;
        int maxFrequencyIndex = self.maxFrequency/mul;
        int numDataPointsPerColumn = (maxFrequencyIndex-minFrequencyIndex)/knum;
        float maxHeight = 0;
        
        for(NSUInteger i=0;i<knum;i++) {
            // calculate new column height
            float avg = 0;
            vDSP_meanv(dataBuffer+minFrequencyIndex+i*numDataPointsPerColumn, 1, &avg, numDataPointsPerColumn);
            CGFloat columnHeight = MIN(avg*self.gain, CGRectGetHeight(self.bounds));
            maxHeight = MAX(maxHeight, columnHeight);
            
            // set column height and reset speed and time if needed
            if (columnHeight>heightsByFrequency[i]) {
                heightsByFrequency[i] = columnHeight;

//                speeds[i] = 0;
//                times[i] = 0;
            }
            if (columnHeight>0) {
//                columnHeight = -columnHeight;
                [Arr_M addObject:@(columnHeight/4)];

            }else{
                [Arr_M addObject:@(1)];
            }
//            columnHeight = columnHeight/2;
//            if (columnHeight < 1) {
//                columnHeight = 1;
//            }
//            NSLog(@"%.2f",columnHeight);
//            [Arr_M addObject:@(columnHeight)];
        }
        
//        [self.heightsByTime addObject: [NSNumber numberWithFloat:maxHeight/10]];
//        if (self.heightsByTime.count>knum) {
//            [self.heightsByTime removeObjectAtIndex:0];
//        }
    }
    NSLog(@"%@",Arr_M);
    if (!Arr_M.count) {
        return;
    }
    UIBezierPath *bb = [AxcDrawPath AxcDrawCircularRadiationCenter:CGPointMake(100, 100)
                                                         radius:50
                                                    lineHeights:Arr_M
                                                        outside:YES
                                                     startAngle:-90
                                                   openingAngle:0
                                                      clockwise:NO];
    self.bzLayer.path = bb.CGPath;
}

- (NSMutableArray *)heightsByTime{
    if (!_heightsByTime) {
        _heightsByTime = @[].mutableCopy;
    }
    return _heightsByTime;
}
- (CAShapeLayer *)bzLayer{
    if (!_bzLayer) {
        _bzLayer = [CAShapeLayer new];
        _bzLayer.lineWidth = 2;
        _bzLayer.strokeColor = [UIColor orangeColor].CGColor;
        [self.layer addSublayer:_bzLayer];
    }
    return _bzLayer;
}

@end
