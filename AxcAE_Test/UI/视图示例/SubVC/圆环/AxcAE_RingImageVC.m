//
//  AxcAE_RingImageVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_RingImageVC.h"

@interface AxcAE_RingImageVC ()
@property(nonatomic , strong)AxcAE_RingImageView *ringImageView;
@end

@implementation AxcAE_RingImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kVCBackColor;

    [self createStartAnimationBtn];
}
- (void)createUI{
    [self.ringImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.bottom.mas_equalTo(-100);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
}

- (void)click_startAnimationBtn{
    self.ringImageView.alpha = 0;
    [self.ringImageView.imageModels enumerateObjectsUsingBlock:^(AxcAE_RingImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 如果为0 会报<CGAffineTransformInvert: singular matrix.>的错误，所以可以设置的小一点
        // obj.imageView.transform = CGAffineTransformMakeScale(0.00001f, 0.00001f);
        obj.imageView.transform = CGAffineTransformMakeScale(0, 0);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.ringImageView.alpha = 1;
    }completion:^(BOOL finished) {
        [self.ringImageView.imageModels enumerateObjectsUsingBlock:^(AxcAE_RingImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [UIView animateWithDuration:0.7 delay:idx * 0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                obj.imageView.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
    [self.ringImageView startAnimation];
}

- (AxcAE_RingImageView *)ringImageView{
    if (!_ringImageView) {
        _ringImageView = [AxcAE_RingImageView new];
        
        _ringImageView.imageModels = [self createImageModels];
        [self.view addSubview:_ringImageView];
        // 为出现动画做准备
        _ringImageView.alpha = 0;
    }
    return _ringImageView;
}

- (NSArray *)createImageModels{
    NSArray <NSString *>*imgNames = @[@"ring_3",@"ring_2",@"ring_5",@"ring_0"];
    NSMutableArray *arr = @[].mutableCopy;
    int i = 0;
    for (NSString *imgName in imgNames) {
        AxcAE_RingImageModel *ring = [AxcAE_RingImageModel drawModelWithImage:[UIImage imageNamed:imgName]];
        switch (i) {
            case 0:{
                ring.tintColor = KScienceTechnologyBlue;
                ring.distance = 10;
                ring.animationBlock = ^(UIImageView *imageView) {
                    [imageView.layer addAnimation:[AxcCAAnimation AxcRotatingDuration:10] forKey:@"123"];
                };
            }break;
            case 1:{
                ring.tintColor = [UIColor whiteColor];
                ring.distance = 15;
                ring.animationBlock = ^(UIImageView *imageView) {
                    [imageView.layer addAnimation:[AxcCAAnimation AxcRotatingDuration:15 clockwise:NO] forKey:@"123"];
                };
            }break;
            case 2:{
                ring.tintColor = KScienceTechnologyBlue;
                ring.distance = 20;
                ring.animationBlock = ^(UIImageView *imageView) {
                    [imageView.layer addAnimation:[AxcCAAnimation AxcRotatingDuration:25] forKey:@"123"];
                };
            }break;
            case 3:{
                ring.tintColor = [UIColor colorWithWhite:1 alpha:0.7];
                ring.distance = 30;
                ring.animationBlock = ^(UIImageView *imageView) {
                    [imageView.layer addAnimation:[AxcCAAnimation AxcRotatingDuration:20 clockwise:NO] forKey:@"123"];
                };
            }break;
            default: break;
        }
        [arr addObject:ring];
        i ++;
    }
    return arr;
}

@end
