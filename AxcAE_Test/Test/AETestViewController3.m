//
//  AETestViewController3.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/10.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AETestViewController3.h"

#import "AxcCameraView.h"

@interface AETestViewController3 ()
@property(nonatomic , strong)AxcCameraView *cameraView;


@end

@implementation AETestViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(100);
        make.bottom.mas_equalTo(50);
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.cameraView startRunning];
}

#pragma mark - 懒加载
- (AxcCameraView *)cameraView{
    if (!_cameraView) {
        _cameraView = [AxcCameraView new];
        _cameraView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_cameraView];
    }
    return _cameraView;
}

@end
