//
//  MQPhotoCell.m
//  MQPhotoLayoutDemo
//
//  Created by qiuming on 16/1/10.
//  Copyright © 2016年 qiuming. All rights reserved.
//

#import "MQPhotoCell.h"
@interface MQPhotoCell()
// 图片视图
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end

@implementation MQPhotoCell

- (void)awakeFromNib {
    self.photoView.layer.borderWidth = 5;
    self.photoView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.photoView.layer.cornerRadius = 10;
    self.photoView.layer.masksToBounds = YES;
    
}

- (void)setImage:(NSString *)image
{
    _image = [image copy];
    _photoView.image = [UIImage imageNamed:image];
}

@end
