//
//  AxcCameraView.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/12.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcCameraView.h"
#import "UIImage+fixOrientation.h"

@interface AxcCameraView ()<AVCaptureVideoDataOutputSampleBufferDelegate>{
    UIView *m_highlitView[100];
    CGAffineTransform m_transform[100];
}

@property(nonatomic , strong) AVCaptureVideoPreviewLayer *previewLayer;

@property(nonatomic , strong)UIView *vvvv;

@end
@implementation AxcCameraView
#pragma mark - init&ParentClass
- (instancetype)init{
    self = [super init];
    if (self) [self configuration];
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) [self configuration];
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) [self configuration];
    return self;
}
#pragma mark - 子类扩展
- (void)configuration{

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.previewLayer.frame = self.bounds;
}

- (void)a{
}


- (void)startRunning {
    [self.session startRunning];
}
- (void)stopRunning {
    [self.session stopRunning];
}

//从摄像头缓冲区获取图像
#pragma mark -
#pragma mark AVCaptureSession delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef newContext = CGBitmapContextCreate(baseAddress,
                                                    width, height, 8, bytesPerRow, colorSpace,
                                                    kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    
    CGContextRelease(newContext);
    CGColorSpaceRelease(colorSpace);

    UIImage *image= [UIImage imageWithCGImage:newImage scale:1 orientation:UIImageOrientationLeftMirrored];
    
    CGImageRelease(newImage);
    image = [image fixUIImageOrientation:image];//图像反转

    [self detectForFacesInUIImage:image];
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
}
/////人脸识别
-(void)detectForFacesInUIImage:(UIImage *)facePicture{
    CIImage* image = [CIImage imageWithCGImage:facePicture.CGImage];
    
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyLow forKey:CIDetectorAccuracy]];
    NSArray* features = [detector featuresInImage:image];
    //    NSLog(@"%f---%f",facePicture.size.width,facePicture.size.height);
    
    int i=0;
    for(CIFaceFeature* faceObject in features){
        dispatch_async(dispatch_get_main_queue(), ^{

            CGFloat XP = self.frame.size.width / facePicture.size.width;
            CGFloat YP = self.frame.size.height / facePicture.size.height;
            CGRect frame = CGRectMake(faceObject.bounds.origin.x * XP,
                                      faceObject.bounds.origin.y * YP,
                                      faceObject.bounds.size.width * XP,
                                      faceObject.bounds.size.height * YP);

            [self addSubViewWithFrame:faceObject.bounds index:i];

        });
        i++;
    }
}
///自画图像
-(void)addSubViewWithFrame:(CGRect)frame  index:(int)_index
{
    if(m_highlitView[_index]==nil)
    {
        m_highlitView[_index]= [[UIView alloc] initWithFrame:frame];
        m_highlitView[_index].layer.borderWidth = 2;
        m_highlitView[_index].layer.borderColor = [[UIColor redColor] CGColor];
        [self addSubview:m_highlitView[_index]];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"found face!!!!!!";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20];
        label.frame = CGRectMake(0, 0, frame.size.width, 20);
        [m_highlitView[_index] addSubview:label];
        
        UIImageView *bqImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bq.png"]];
        bqImage.frame = CGRectMake(0, -30, 30, 30);
        [m_highlitView[_index] addSubview:bqImage];
        
        m_transform[_index] = m_highlitView[_index].transform;
    }
    frame.origin.x = frame.origin.x/1.5;
    frame.origin.y = frame.origin.y/1.5;
    frame.size.width = frame.size.width/1.5;
    frame.size.height = frame.size.height/1.5;
    m_highlitView[_index].frame = frame;
    
    ///根据头像大小缩放自画View
    float scale = frame.size.width/220;
    CGAffineTransform transform = CGAffineTransformScale(m_transform[_index], scale,scale);
    m_highlitView[_index].transform = transform;
    
    m_highlitView[_index].hidden = NO;
}

#pragma mark - 懒加载
- (AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.layer addSublayer:_previewLayer];
    }
    return _previewLayer;
}
- (AVCaptureVideoDataOutput *)captureOutput{
    if (!_captureOutput) {
        _captureOutput = [AVCaptureVideoDataOutput new];
//        _captureOutput.minFrameDuration = CMTimeMake(1, 60);

        _captureOutput.alwaysDiscardsLateVideoFrames = YES;
        dispatch_queue_t queue;
        queue = dispatch_queue_create("cameraQueue", NULL);
        [_captureOutput setSampleBufferDelegate:self queue:queue];
        NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
        NSNumber* value = [NSNumber
                           numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
        NSDictionary* videoSettings = [NSDictionary
                                       dictionaryWithObject:value forKey:key];
        [_captureOutput setVideoSettings:videoSettings];
    }
    return _captureOutput;
}
- (AVCaptureSession *)session{
    if (!_session) {
        _session = [AVCaptureSession new];
        _session.sessionPreset = AVCaptureSessionPresetHigh;
        // 3 获取摄像头device,并且默认使用的后置摄像头,并且将摄像头加入到captureSession中
        AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];

        [_session addInput:deviceInput];
        // 设置输出
        [_session addOutput:self.captureOutput];
    }
    return _session;
}



@end
