//
//  AxcCameraView.h
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/12.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AxcCameraView : UIView
// 会话层
@property(nonatomic , strong)AVCaptureSession *session;
// 输出
@property(nonatomic , strong)AVCaptureVideoDataOutput *captureOutput;

- (void)startRunning;

- (void)stopRunning;

@end

NS_ASSUME_NONNULL_END
