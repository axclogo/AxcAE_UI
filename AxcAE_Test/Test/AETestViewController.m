//
//  AETestViewController.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AETestViewController.h"

#import "UIViewController+AxcAE_ViewControllerExtension.h"

#import "AxcAE_UI.h"

#import "AxcBF_FaceRecognition.h"

#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>


@interface AETestViewController () <
ARSCNViewDelegate,
ARSessionDelegate,
AVCaptureVideoDataOutputSampleBufferDelegate,
AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic , strong)ARSCNView *sceneView;

@property(nonatomic , strong)NSTimer *timer;

@property(nonatomic , strong)UIView *faceView;

@property(nonatomic , strong)CIImage *ciImage;
@property(nonatomic , strong)CIContext *temporaryContext;
@property(nonatomic )CGImageRef videoImage;

@end

@implementation AETestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackColor;
    
    self.temporaryContext = [CIContext contextWithOptions:nil];

    [self createStartAnimationBtn];
}



- (UIImage*)imageFromPixelBuffer:(CMSampleBufferRef)p {
    CVImageBufferRef buffer;
    buffer = CMSampleBufferGetImageBuffer(p);
    CVPixelBufferLockBaseAddress(buffer, 0);
   uint8_t *base;
   size_t width, height, bytesPerRow;
   base = (uint8_t *)CVPixelBufferGetBaseAddress(buffer);
   width = CVPixelBufferGetWidth(buffer);
   height = CVPixelBufferGetHeight(buffer);
   bytesPerRow = CVPixelBufferGetBytesPerRow(buffer);
   CGColorSpaceRef colorSpace;
   CGContextRef cgContext;
   colorSpace = CGColorSpaceCreateDeviceRGB();
   cgContext = CGBitmapContextCreate(base, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
   CGColorSpaceRelease(colorSpace);
   CGImageRef cgImage;
   UIImage *image;
   cgImage = CGBitmapContextCreateImage(cgContext);
   image = [UIImage imageWithCGImage:cgImage];
   CGImageRelease(cgImage);
   CGContextRelease(cgContext);
   CVPixelBufferUnlockBaseAddress(buffer, 0);
   return image;
}

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor{
    if ([anchor isKindOfClass:[ARPlaneAnchor class]]) {
        ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
        SCNPlane *plane = [SCNPlane planeWithWidth:planeAnchor.extent.x height: planeAnchor.extent.z];
        
        SCNNode *planeNode = [SCNNode new];
        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
        planeNode.transform = SCNMatrix4MakeRotation(-M_PI/2, 1, 0, 0);
        SCNMaterial *gridMaterial = [SCNMaterial new];
        gridMaterial.diffuse.contents = [UIImage imageNamed:@"art.scnassets/grid.png"];
        plane.materials = @[gridMaterial];
        planeNode.geometry = plane;
        [node addChildNode:planeNode];
    }
    if ([anchor isKindOfClass:[ARFaceAnchor class]]) {
        SCNBox *box = [SCNBox boxWithWidth:0.08 height:0.08 length:0.08 chamferRadius:0];
        SCNNode *faceNode = [SCNNode nodeWithGeometry:box];
        [node addChildNode:faceNode];
    }
    NSLog(@"111");
}


- (void)createUI{
    [self.sceneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.view addSubview:self.faceView];

    // 平面检测
    ARFaceTrackingConfiguration *conf = [ARFaceTrackingConfiguration new];
//        conf.planeDetection = ARPlaneDetectionVertical;
    conf.lightEstimationEnabled = YES;
    [self.sceneView.session runWithConfiguration:conf];
}
- (void)click_startAnimationBtn{
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(reloadFaceImg) userInfo:nil repeats:YES];
}

- (UIView *)faceView{
    if (!_faceView) {
        _faceView = [UIView new];
        _faceView.alpha = 0.5;
        _faceView.backgroundColor = [UIColor lightGrayColor];
    }
    return _faceView;
}

- (ARSCNView *)sceneView{
    if (!_sceneView) {
        _sceneView = [ARSCNView new];
        _sceneView.delegate = self;
        _sceneView.session.delegate = self;
        _sceneView.scene = [SCNScene new];
        _sceneView.allowsCameraControl = YES;
//        _sceneView.session.currentFrame.camera.trackingStateReason = ARTrackingStateReasonInsufficientFeatures;
// 操作摄像机
        _sceneView.showsStatistics = YES;
        _sceneView.debugOptions =
        ARSCNDebugOptionShowFeaturePoints |
//        SCNDebugOptionShowBoundingBoxes |
//        SCNDebugOptionShowPhysicsShapes ;
        SCNDebugOptionShowWireframe;
        
        [self.view addSubview:_sceneView];
    }
    return _sceneView;
}

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

@end
