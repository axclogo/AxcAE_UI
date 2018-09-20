//
//  UIView+AxcAE_ViewFrame.m
//  Axc_AEUI
//
//  Created by Axc on 2018/6/7.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "UIView+AxcAE_ViewFrame.h"

@implementation UIView (AxcAE_ViewFrame)

- (void)setAxcAE_X:(CGFloat)axcAE_X
{
    CGRect frame = self.frame;
    frame.origin.x = axcAE_X;
    self.frame = frame;
}

- (void)setAxcAE_Y:(CGFloat)axcAE_Y
{
    CGRect frame = self.frame;
    frame.origin.y = axcAE_Y;
    self.frame = frame;
}

- (CGFloat)axcAE_X
{
    return self.frame.origin.x;
}

- (CGFloat)axcAE_Y
{
    return self.frame.origin.y;
}

- (void)setAxcAE_Width:(CGFloat)axcAE_Width
{
    CGRect frame = self.frame;
    frame.size.width = axcAE_Width;
    self.frame = frame;
}

- (void)setAxcAE_Height:(CGFloat)axcAE_Height
{
    CGRect frame = self.frame;
    frame.size.height = axcAE_Height;
    self.frame = frame;
}

- (CGFloat)axcAE_Height
{
    return self.frame.size.height;
}

- (CGFloat)axcAE_Width
{
    return self.frame.size.width;
}

- (UIView * (^)(CGFloat x))setX{
    return ^(CGFloat x) {
        self.axcAE_X = x;
        return self;
    };
}

- (void)setAxcAE_CenterX:(CGFloat)axcAE_CenterX
{
    CGPoint center = self.center;
    center.x = axcAE_CenterX;
    self.center = center;
}

- (CGFloat)axcAE_CenterX
{
    return self.center.x;
}

- (void)setAxcAE_CenterY:(CGFloat)axcAE_CenterY
{
    CGPoint center = self.center;
    center.y = axcAE_CenterY;
    self.center = center;
}

- (CGFloat)axcAE_CenterY
{
    return self.center.y;
}

- (void)setAxcAE_Size:(CGSize)axcAE_Size
{
    CGRect frame = self.frame;
    frame.size = axcAE_Size;
    self.frame = frame;
}

- (CGSize)axcAE_Size
{
    return self.frame.size;
}

- (void)setAxcAE_Origin:(CGPoint)axcAE_Origin
{
    CGRect frame = self.frame;
    frame.origin = axcAE_Origin;
    self.frame = frame;
}

- (CGPoint)axcAE_Origin
{
    return self.frame.origin;
}

- (CGFloat)axcAE_Left {
    return self.frame.origin.x;
}

- (void)setAxcAE_Left:(CGFloat)axcAE_Left {
    CGRect frame = self.frame;
    frame.origin.x = axcAE_Left;
    self.frame = frame;
}

- (CGFloat)axcAE_Top {
    return self.frame.origin.y;
}

- (void)setAxcAE_Top:(CGFloat)axcAE_Top {
    CGRect frame = self.frame;
    frame.origin.y = axcAE_Top;
    self.frame = frame;
}

- (CGFloat)axcAE_Right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setAxcAE_Right:(CGFloat)axcAE_Right {
    CGRect frame = self.frame;
    frame.origin.x = axcAE_Right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)axcAE_Bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setAxcAE_Bottom:(CGFloat)axcAE_Bottom {
    CGRect frame = self.frame;
    frame.origin.y = axcAE_Bottom - frame.size.height;
    self.frame = frame;
}

#pragma mark - rewrite
- (UIView *(^)(UIColor *color)) setColor{
    return ^ (UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (UIView *(^)(CGRect frame)) setFrame{
    return ^ (CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGSize size)) setSize{
    return ^ (CGSize size) {
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        return self;
    };
}

- (UIView *(^)(CGPoint point)) setCenter{
    return ^ (CGPoint point) {
        self.center = point;
        return self;
    };
}
- (UIView *(^)(NSInteger tag)) setTag{
    return ^ (NSInteger tag) {
        self.tag = tag;
        return self;
    };
}

@end
