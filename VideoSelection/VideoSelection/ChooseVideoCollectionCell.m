//
//  ChooseVideoCollectionCell.m
//  Shaolin
//
//  Created by edz on 2020/3/16.
//  Copyright © 2020 syqaxldy. All rights reserved.
//
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight ([UIScreen mainScreen].bounds.size.height)
#import "ChooseVideoCollectionCell.h"

@implementation ChooseVideoCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    [self.contentView addSubview:self.imageV];
    [self.imageV addSubview:self.timeLabel];
    [self.contentView addSubview:self.selectView];
   
}
-(UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (kWidth-3)/4, (kWidth-3)/4)];
        _imageV.backgroundColor = [UIColor blueColor];
    }
    return _imageV;
}
-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((kWidth-3)/4-50, (kWidth-3)/4-25, 40, 15)];
        _timeLabel.font = [UIFont systemFontOfSize:11.0f];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor whiteColor];
    }
    return _timeLabel;
}
-(UIView *)selectView
{
    if (!_selectView) {
        _selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (kWidth-3)/4, (kWidth-3)/4)];
        _selectView.layer.borderColor = [UIColor whiteColor].CGColor;
        _selectView.layer.borderWidth = 2;
        _selectView.backgroundColor = [UIColor clearColor];
    }
    return _selectView;
}
@end
