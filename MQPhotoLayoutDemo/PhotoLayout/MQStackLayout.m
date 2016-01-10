//
//  MQStackLayout.m
//  MQPhotoLayoutDemo
//
//  Created by qiuming on 16/1/10.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import "MQStackLayout.h"

@implementation MQStackLayout
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arrayM = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        [arrayM addObject:attri];
    }
    return arrayM;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat centerX = self.collectionView.frame.size.width * 0.5;
    CGFloat centerY = self.collectionView.frame.size.height * 0.5;
    attri.center = CGPointMake(centerX, centerY);
    attri.size = CGSizeMake(150, 150);
    attri.zIndex = - indexPath.item;
    if (indexPath.item == 0) {
        return attri;
    }
    if (indexPath.item > 4) {
        attri.hidden = YES;
        return attri;
    }
    
    NSArray *angles = @[@0, @(0.2), @(-0.2), @(0.5), @(-0.5)];
    CGFloat angle = [angles[indexPath.item] doubleValue];
    
    attri.transform = CGAffineTransformMakeRotation(angle);
    
    return attri;
}
@end
