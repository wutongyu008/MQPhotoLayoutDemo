//
//  ViewController.m
//  MQPhotoLayoutDemo
//
//  Created by qiuming on 16/1/9.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import "ViewController.h"
#import "MQLineLayout.h"
#import "MQPhotoCell.h"
#import "MQCircleLayout.h"
#import "MQStackLayout.h"

#define viewWidth self.view.bounds.size.width
NSString *const PhotoLayoutReusedID = @"PhotoLayoutReusedID";


@interface ViewController ()<UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;
// 图片数组
@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 添加控件
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - UICollectionViewDateSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MQPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoLayoutReusedID forIndexPath:indexPath];
    
    cell.image = self.images[indexPath.item];
    
    return cell;
}


/// 切换模式
- (IBAction)switchModel {
    if ([self.collectionView.collectionViewLayout isKindOfClass:[MQLineLayout class]]) {
        
        [self.collectionView setCollectionViewLayout:[[MQCircleLayout alloc]init] animated:YES];
        
    } else if ([self.collectionView.collectionViewLayout isKindOfClass:[MQCircleLayout class]]){
        
        [self.collectionView setCollectionViewLayout:[[MQStackLayout alloc]init] animated:YES];
    } else {
        [self.collectionView setCollectionViewLayout:[[MQLineLayout alloc]init] animated:YES];
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 先删除数据源
    [self.images removeObjectAtIndex:indexPath.item];
    
    // 刷新数据
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        MQLineLayout *layout = [[MQLineLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, viewWidth, 300) collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"MQPhotoCell" bundle:nil] forCellWithReuseIdentifier:PhotoLayoutReusedID];
    
    }
    return _collectionView;
}

- (NSMutableArray *)images {
    if (_images == nil) {
        _images = [[NSMutableArray alloc]init];
        for (int i = 1; i <= 20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _images;
}

@end
