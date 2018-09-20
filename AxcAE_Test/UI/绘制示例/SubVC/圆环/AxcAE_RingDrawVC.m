//
//  AxcAE_RingDrawVC.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/18.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_RingDrawVC.h"

@interface AxcAE_RingDrawVC ()
@property(nonatomic , strong)AxcAE_RingDrawView *ringDrawView;
@end

@implementation AxcAE_RingDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createStartAnimationBtn];
    self.view.backgroundColor = kVCBackColor;
}
- (void)createUI{
    [self.ringDrawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.bottom.mas_equalTo(-100);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
}
- (void)click_startAnimationBtn{
    [self.ringDrawView startAnimation];
}


- (AxcAE_RingDrawView *)ringDrawView{
    if (!_ringDrawView) {
        _ringDrawView = [AxcAE_RingDrawView new];
        
        _ringDrawView.drawModels = [self createImageModels];
        [self.view addSubview:_ringDrawView];
    }
    return _ringDrawView;
}

- (NSArray *)createImageModels{
    NSArray <NSString *>*imgNames = @[@"ring_3",@"ring_2",@"ring_5",@"ring_0"];
    NSMutableArray *arr = @[].mutableCopy;
    int i = 0;
    for (NSString *imgName in imgNames) {
        AxcAE_RingDrawModel *ring = [AxcAE_RingDrawModel imageModelWithImage:[UIImage imageNamed:imgName]];
        switch (i) {
            case 0:{
                ring.tintColor = KScienceTechnologyBlue;
                ring.distance = 10;
                ring.animationBlock = ^CAAnimation *{
                    return [AxcCAAnimation AxcRotatingDuration:10];
                };
            }break;
            case 1:{
                ring.tintColor = [UIColor whiteColor];
                ring.distance = 15;
                ring.animationBlock = ^CAAnimation *{
                    return [AxcCAAnimation AxcRotatingDuration:15 clockwise:NO];
                };
            }break;
            case 2:{
                ring.tintColor = KScienceTechnologyBlue;
                ring.distance = 20;
                ring.animationBlock = ^CAAnimation *{
                    return [AxcCAAnimation AxcRotatingDuration:25];
                };
            }break;
            case 3:{
                ring.tintColor = [UIColor colorWithWhite:1 alpha:0.7];
                ring.distance = 30;
                ring.animationBlock = ^CAAnimation *{
                    return [AxcCAAnimation AxcRotatingDuration:20 clockwise:NO];
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
