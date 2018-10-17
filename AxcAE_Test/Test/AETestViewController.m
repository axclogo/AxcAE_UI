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
#import "UIImage+fixOrientation.h"


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


@property(nonatomic , strong)AxcAE_ScopeDrawView *scopeDrawView ;
@property(nonatomic , strong)UIImageView *imgV ;

@end

@implementation AETestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackColor;
    
    self.temporaryContext = [CIContext contextWithOptions:nil];

    [self createStartAnimationBtn];
    
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
        
        
        
//        self.scopeDrawView.transform = CGAffineTransformMake(anchor.transform.columns[0], anchor.transform.columns[1], 0,
//                                                             anchor.transform.columns[3], anchor.transform.columns[4], 0);
        
//        self.scopeDrawView.hidden = NO;
//        self.scopeDrawView.frame = CGRectMake(planeAnchor.center.x, planeAnchor.center.z, 100, 100);
        
    }
    if ([anchor isKindOfClass:[ARFaceAnchor class]]) {
        SCNBox *box = [SCNBox boxWithWidth:0.08 height:0.08 length:0.08 chamferRadius:0];
        SCNNode *faceNode = [SCNNode nodeWithGeometry:box];
        [node addChildNode:faceNode];
    }
    NSLog(@"111");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    
    NSLog(@"%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
    UIImage *img = [self uiImageFromPixelBuffer:self.sceneView.session.currentFrame.capturedImage width:2000 height:2000];
    img = [UIImage image:img rotation:UIImageOrientationRight]; // 旋转
    img = [self scaleImage:img toScale:self.sceneView.frame.size.height/img.size.height]; // 缩放
    img = [self imageByCroppingWithImage:img];      // 截取显示区
    UIImage *img_2 = [self imageByCroppingWithImage:img rect:CGRectMake(point.x-50, point.y-50, 100, 100)];

    
    self.scopeDrawView.hidden = NO;
    self.scopeDrawView.transform = CGAffineTransformMakeScale(10, 10);
    
    self.scopeDrawView.center = point;

    [UIView animateWithDuration:0.2 animations:^{
        self.scopeDrawView.transform = CGAffineTransformMakeScale(1, 1);
    }completion:^(BOOL finished) {
        [self.scopeDrawView startContinuousAnimation];
        self.imgV.frame = CGRectMake(point.x + 50, point.y + 50, 100, 100);
        self.imgV.image = img_2;
        self.imgV.hidden = NO;
    }];
}

- (UIImage*)uiImageFromPixelBuffer:(CVPixelBufferRef)p width:(CGFloat)width height:(CGFloat)height {
    CIImage* ciImage = [CIImage imageWithCVPixelBuffer:p];
    CIContext* context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}];
    CGImageRef videoImage = [context createCGImage:ciImage fromRect:ciImage.extent];
    UIImage* image = [UIImage imageWithCGImage:videoImage];
    CGImageRelease(videoImage);
    
    return image;
}
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize )size
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * (size.width/image.size.width), image.size.height * (size.height/image.size.height)));
    [image drawInRect:CGRectMake(0, 0, image.size.width * (size.width/image.size.width), image.size.height * (size.height/image.size.height))];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
//剪裁图片
-(UIImage*)imageByCroppingWithImage:(UIImage*)myImage{
    CGRect rect = CGRectMake(myImage.size.width/2 - self.sceneView.bounds.size.width/2,
                             myImage.size.height/2 - self.sceneView.bounds.size.height/2,
                             self.sceneView.bounds.size.width, self.sceneView.bounds.size.height);
    
    CGImageRef imageRef = myImage.CGImage;
    CGImageRef imagePartRef=CGImageCreateWithImageInRect(imageRef,rect);
    UIImage * cropImage=[UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    
    return cropImage;
}
//剪裁图片
-(UIImage*)imageByCroppingWithImage:(UIImage*)myImage rect:(CGRect )rect{
    CGImageRef imageRef = myImage.CGImage;
    CGImageRef imagePartRef=CGImageCreateWithImageInRect(imageRef,rect);
    UIImage * cropImage=[UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    
    return cropImage;
}



- (AxcAE_ScopeDrawView *)scopeDrawView{
    if (!_scopeDrawView) {
        _scopeDrawView = [AxcAE_ScopeDrawView new];
        _scopeDrawView.style = AxcAE_ScopeDrawStyleScale;
//        _scopeDrawView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _scopeDrawView.frame = CGRectMake(self.view.axcAE_Width/2 -50, self.view.axcAE_Height/2 -50, 100, 100);
        [_scopeDrawView layoutSubviews];
        _scopeDrawView.hidden = YES;
        [self.view addSubview:_scopeDrawView];
    }
    return _scopeDrawView;
}
- (UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.hidden = YES;
        [self.view addSubview:_imgV];
    }
    return _imgV;
}

- (void)createUI{
    [self.sceneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.view addSubview:self.faceView];

    // 平面检测
    ARWorldTrackingConfiguration *conf = [ARWorldTrackingConfiguration new];
//    conf.planeDetection = ARPlaneDetectionHorizontal;
    conf.lightEstimationEnabled = YES;
    [self.sceneView.session runWithConfiguration:conf];
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
