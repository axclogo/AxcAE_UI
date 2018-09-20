//
//  AETestViewController.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/19.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AETestViewController.h"

#import "AxcAE_UI.h"

@interface AETestViewController ()

@property(nonatomic , strong)AxcAE_DrawBoard *drawBoard;

@end

@implementation AETestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.drawBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.top.mas_equalTo(100);
        make.bottom.mas_equalTo(-100);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CAShapeLayer *dottedLine = [self.drawBoard layerWithTag:100];
    [dottedLine addAnimation:[AxcCAAnimation AxcDrawLineDuration:10] forKey:nil];
}


- (AxcAE_DrawBoard *)drawBoard{
    if (!_drawBoard) {
        _drawBoard = [AxcAE_DrawBoard new];
        _drawBoard.backgroundColor = kBackColor;
//        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawBlockArcRingCenter:CGPointMake(100,200)
//                                                            outsideRadius:100
//                                                              blockRadius:30
//                                                               blockCount:20
//                                                             angleSpacing:3];
        
        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawBlockArcRingCenter:CGPointMake(150,130) radius:110];
        
//        UIBezierPath *bezierPath = [AxcDrawPath AxcDrawParallelogramStartPoint:CGPointMake(100, 100)
//                                                                          size:CGSizeMake(100, 200)
//                                                                        offset:CGPointMake(30, -30 )
//                                                                     clockwise:NO];
        
        CAShapeLayer *dottedLine = [AxcLayerBrush AxcLayerDottedLineWidth:3
                                                              strokeColor:[UIColor grayColor]
                                                               bezierPath:bezierPath
                                                          lineDashPattern:@[@(1.0),@(3.0)]];
        dottedLine.tag = 100;
        [_drawBoard drawSublayer:dottedLine];
        
      
        
        [self.view addSubview:_drawBoard];
    }
    return _drawBoard;
}


@end
