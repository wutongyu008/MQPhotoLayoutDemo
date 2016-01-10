//
//  MQLineLayout.m
//  MQPhotoLayoutDemo
//
//  Created by qiuming on 16/1/9.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import "MQLineLayout.h"
#define collectionViewWidth  self.collectionView.frame.size.width
#define collectionViewHeight self.collectionView.frame.size.height

@implementation MQLineLayout


- (void)prepareLayout {
    [super prepareLayout];
    
    // 设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置Item的大小
    CGFloat itemWH = collectionViewWidth * 0.6;
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
    // 设置item的内边距
    CGFloat inset = (collectionViewWidth - itemWH) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

/**
 * 返回collectionView每个item的布局属性
 * 此方法决定了collectionView的每个item怎样排列
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 因为是流水布局，父类已经做好了一些排列，我们只需取出再做一些补充即可
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 获得collectionView最中间的X值
    CGFloat centerX = self.collectionView.contentOffset.x + collectionViewWidth * 0.5;
    
    // 在默认的布局上做些补充
    for (UICollectionViewLayoutAttributes *attri in array) {
        // 计算item的中点和collectionView的中点之间的差值
        CGFloat delta = ABS(centerX - attri.center.x);
        // 利用差值计算缩放比例（成反比）
        CGFloat scale = 1.0 - delta / (collectionViewWidth + self.itemSize.width);
        attri.transform = CGAffineTransformMakeScale(scale, scale);
        
    }
    
    return array.copy;
}

/**
 * 当UICollectionView的Bounds发生改变时会自动调用,刷新布局
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 * targetContentOffset ：通过修改后，collectionView最终的contentOffset(取决定情况)
 * proposedContentOffset ：默认情况下，collectionView最终的contentOffset
 */

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    // 计算最终的可见范围
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    
    // 取出可见范围内item的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 获得collectionView最中间的X值
    CGFloat centerX = proposedContentOffset.x + collectionViewWidth * 0.5;
    
    // 计算最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attri in array) {
        if (ABS(minDelta) > ABS(attri.center.x - centerX)) {
            minDelta = attri.center.x - centerX;
        }
    }
    
    // 在原有的offset基础上微调使item剧中显示
    return CGPointMake(proposedContentOffset.x + minDelta, proposedContentOffset.y);
}

@end










