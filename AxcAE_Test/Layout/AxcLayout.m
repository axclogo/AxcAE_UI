//
//  AxcLayout.m
//  AxcAE_Test
//
//  Created by AxcLogo on 2018/9/28.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcLayout.h"
#import "AxcAE_UIDefine.h"
@interface AxcLayout ()

/** attrs的数组 */
@property (nonatomic, strong) NSMutableArray *attrsArr;

@property(nonatomic , assign)NSInteger changeIdx;
@property(nonatomic , assign)NSInteger changeIdy;

@end

@implementation AxcLayout
- (instancetype)init{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.radius = 25;
        self.spacing = 5;
        self.changeIdx = 0;
        self.changeIdy = 0;
        self.rowMaxCount = 5;
        self.isAutoRowMaxCount = YES;
    }
    return self;
}
-(void)prepareLayout{
    [super prepareLayout];
    [self.attrsArr removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i ++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attrs];
    }
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArr;
}
- (CGSize)collectionViewContentSize{
    return [super collectionViewContentSize];
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.collectionView.frame.size.width;
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat shortLength = (self.radius / tanf(AxcAE_Angle(60)));
    CGFloat rightRadius = (self.radius*2 - shortLength) + self.spacing;
    if (self.isAutoRowMaxCount) {
        NSInteger count = width/(2*self.radius-shortLength + self.spacing);
        self.rowMaxCount = count;
    }
    // 计算每行最大
    BOOL isNewline = !(indexPath.row % self.rowMaxCount) && indexPath.row;
    if (isNewline) { // 该换行了
        self.changeIdx = 0;
    }
    
    CGFloat X = indexPath.row *rightRadius;
    X = self.changeIdx *rightRadius;
    

    
    CGFloat Y = 0;
    CGFloat verticalEdge = self.radius*cosf(AxcAE_Angle(30));
    Y = self.changeIdy *(verticalEdge*2 + self.spacing);
    if ((self.changeIdx % 2)) {
        Y += verticalEdge + self.spacing/2;
    }
    attrs.frame = CGRectMake(X, Y, 50, 50);
    
    self.changeIdx ++;
    if ((self.changeIdx == self.rowMaxCount)) { // 该换行了
        self.changeIdy ++;
    }
    return attrs;
}

#pragma mark - 懒加载
- (NSMutableArray *)attrsArr
{
    if(!_attrsArr)
    {
        _attrsArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _attrsArr;
}
@end
