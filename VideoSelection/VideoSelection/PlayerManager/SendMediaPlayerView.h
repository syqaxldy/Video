//
//  SendMediaPlayerView.h
//  Shaolin
//
//  Created by edz on 2020/3/13.
//  Copyright © 2020 syqaxldy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SendMediaPlayerView : UIView
/** 开始播放按钮 */
@property (strong, nonatomic)  UIButton       *startBtn;
/** 当前播放时长label */
@property (strong, nonatomic)  UILabel        *currentTimeLabel;
/** 视频总时长label */
@property (strong, nonatomic)  UILabel        *totalTimeLabel;
/** 缓冲进度条 */
@property (strong, nonatomic)  UIProgressView *progressView;
/** 滑杆 */
@property (strong, nonatomic)  UISlider       *videoSlider;
/** 全屏按钮 */
@property (strong, nonatomic)  UIButton       *fullScreenBtn;
@property (strong, nonatomic)  UIButton       *lockBtn;
/** 音量进度 */
@property (nonatomic,strong) UIProgressView   *volumeProgress;

/** 系统菊花 */
@property (nonatomic,strong)UIActivityIndicatorView *activity;
@end

NS_ASSUME_NONNULL_END
