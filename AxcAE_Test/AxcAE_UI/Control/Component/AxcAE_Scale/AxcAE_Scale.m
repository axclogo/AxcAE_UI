//
//  AxcAE_Scale.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/10/10.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcAE_Scale.h"
@interface AxcAE_Scale ()
@property(nonatomic , strong)NSMutableArray <CATextLayer *>*textLayerArray;
@end
@implementation AxcAE_Scale
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return self.scrollView;
    }
    return nil;
}
- (void)AxcAE_BaseConfiguration{
    [super AxcAE_BaseConfiguration];
    self.layer.masksToBounds = YES;
    self.count = 20;
    self.groupCount = 10;
    self.bigScaleHeight = 20;
    self.smallScaleHeight = 10;
    self.spacing = 5;
    self.lineWidth = 1.f;
    self.indicatorWidth = 1.f;
    self.minValue = 0.f;
    self.maxValue = 20.f;
    self.isScrollAlign = NO;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self reloadScalePath];
    self.scrollView.frame = self.bounds;
    if (self.isScrollAlign) self.scrollView.axcAE_Width = self.spacing;
    self.scrollView.contentSize = CGSizeMake(self.getContentWidth, self.frame.size.height);
    CGFloat x = (self.axcAE_Width/2)-self.lineWidth/2;
    if (self.lineWidth == self.indicatorWidth) x = (self.axcAE_Width/2)-self.lineWidth;
    self.chassisBoard.frame = CGRectMake(x, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    [self.chassisBoard drawSublayer:self.scaleLayer];
    // 指示器绘制
    self.indicatorLayer.frame = self.bounds;
}

- (CGFloat )getContentWidth{
    return self.count * self.groupCount * self.spacing + (self.isScrollAlign? self.spacing : self.axcAE_Width);
}
- (void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    _scaleLayer.strokeColor = tintColor.CGColor;
}
- (void)setIndicatorWidth:(CGFloat)indicatorWidth{
    _indicatorWidth = indicatorWidth;
    self.indicatorLayer.lineWidth = _indicatorWidth;
}
- (void)setIsScrollAlign:(BOOL)isScrollAlign{
    _isScrollAlign = isScrollAlign;
    self.scrollView.pagingEnabled = _isScrollAlign;
    self.scrollView.clipsToBounds = !_isScrollAlign;
}
- (void)reloadScalePath{
    self.scaleBezierPath = [AxcDrawPath AxcDrawScaleStartPoint:CGPointMake(0, self.axcAE_Height - self.bigScaleHeight)
                                                         count:self.count
                                                    groupCount:self.groupCount
                                                bigScaleHeight:self.bigScaleHeight
                                              smallScaleHeight:self.smallScaleHeight
                                                       spacing:self.spacing];
    // 这一步效率很低，我很不喜欢，有谁能优化下最好
    [self.textLayerArray enumerateObjectsUsingBlock:^(CATextLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    CGFloat increasing = (self.maxValue - self.minValue)/self.count;
    for (int i = 0; i <= self.count; i ++) {
        CATextLayer *layer = [CATextLayer layer];
        layer.frame = CGRectMake(i * (self.spacing * self.groupCount) - 25, self.axcAE_Height - self.bigScaleHeight - 30, 50, 30);
        layer.string = [NSString stringWithFormat:@"%.2f",self.minValue + i * increasing];
        layer.fontSize = 10;
        layer.alignmentMode = kCAAlignmentCenter;
        layer.foregroundColor = self.tintColor.CGColor;
        layer.contentsScale = 9;
        [self.textLayerArray addObject:layer];
        [self.chassisBoard drawSublayer:layer];
    }
    
    
    CGFloat x = (self.axcAE_Width/2)-self.indicatorWidth; // 因为贝塞尔曲线是向内扩展线宽，所以不用二分之一
    UIBezierPath *indicatorPath = [AxcDrawPath AxcDrawLineArray:
  @[[NSValue valueWithCGPoint:CGPointMake(x, 0)],
    [NSValue valueWithCGPoint:CGPointMake(x, self.axcAE_Height)]]];
    self.indicatorLayer.path = indicatorPath.CGPath;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scaleCount = scrollView.contentOffset.x/self.spacing; // 个数
    CGFloat smallScaleValue = (self.maxValue - self.minValue) / (self.count * self.groupCount) * scaleCount;
    __weak typeof(self)weakSelf = self;
    if (self.scaleValueChangeBlock) self.scaleValueChangeBlock(weakSelf,smallScaleValue);
    if ([self.delegate respondsToSelector:@selector(AxcAE_Scale:value:)]){
        [self.delegate AxcAE_Scale:weakSelf value:smallScaleValue];
    }
}

#pragma mark - 懒加载
- (CAShapeLayer *)indicatorLayer{
    if (!_indicatorLayer) {
        _indicatorLayer = [CAShapeLayer new];
        _indicatorLayer.strokeColor = self.tintColor.CGColor;
        [self.layer addSublayer:_indicatorLayer];
    }
    return _indicatorLayer;
}
- (CAShapeLayer *)scaleLayer{
    if (!_scaleLayer) {
        _scaleLayer = [AxcLayerBrush AxcLayerDottedLineWidth:self.lineWidth
                                                 strokeColor:self.tintColor
                                                  bezierPath:self.scaleBezierPath];
    }
    return _scaleLayer;
}
- (AxcAE_DrawBoard *)chassisBoard{
    if (!_chassisBoard) {
        _chassisBoard = [AxcAE_DrawBoard new];
        [self.scrollView addSubview:_chassisBoard];
    }
    return _chassisBoard;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}
- (NSMutableArray <CATextLayer *>*)textLayerArray{
    if (!_textLayerArray) {
        _textLayerArray = @[].mutableCopy;
    }
    return _textLayerArray;
}


@end
