//
//  AxcBufferView.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/19.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <EZAudio.h>

#import "AxcDrawPath.h"

NS_ASSUME_NONNULL_BEGIN

@interface AxcBufferView : EZAudioPlot


/// The upper bound of the frequency range the audio plot will process. Default: 10000Hz
@property (nonatomic) float maxFrequency;

/// The lower bound of the frequency range the audio plot will process. Default: 1200Hz
@property (nonatomic) float minFrequency;

/// A float that specifies the vertical gravitational acceleration applied to bins in the audio plot. Default: 10 pixel/s^2
@property (nonatomic) float gravity;

@end

NS_ASSUME_NONNULL_END
