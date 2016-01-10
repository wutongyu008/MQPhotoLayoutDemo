//
//  MQCircleLayout.m
//  MQPhotoLayoutDemo
//
//  Created by qiuming on 16/1/10.
//  Copyright © 2016年 qiuming. All rights reserved.
//  

#import "MQCircleLayout.h"

@implementation MQCircleLayout

/**
 * 返回collectionView每个item的布局属性
 * 此方法决定了collectionView的每个item怎样排列
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arrayM = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 创建i位置对应的布局属性
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        // 添加布局属性
        [arrayM addObject:attri];
    }
    return arrayM;
}

/**
 * 返回indexPath对应item的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 设置半径
    CGFloat radius = 120;
    
    // 圆心
    CGFloat centerX = self.collectionView.frame.size.width * 0.5;
    CGFloat centerY = self.collectionView.frame.size.height * 0.5;
    
    // 创建对应index的布局属性
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attri.size = CGSizeMake(50, 50);
    // 计算对应的位置
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    if (count == 1) {
        attri.center = CGPointMake(centerX, centerY);
        
    } else {
        CGFloat angle = (2 * M_PI / count) * indexPath.item;
        CGFloat attriCenterX = centerX - radius * cos(angle);
        CGFloat attriCenterY = centerY - radius * sin(angle);
        
        attri.center = CGPointMake(attriCenterX, attriCenterY);
    }
    
    return attri;
}

@end
