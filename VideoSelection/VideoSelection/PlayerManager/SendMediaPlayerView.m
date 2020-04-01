//
//  SendMediaPlayerView.m
//  Shaolin
//
//  Created by edz on 2020/3/13.
//  Copyright © 2020 syqaxldy. All rights reserved.
//

#import "SendMediaPlayerView.h"
#import <AVFoundation/AVFoundation.h>
@interface SendMediaPlayerView()
/** bottomView*/
@property (strong, nonatomic  )  UIImageView     *bottomImageView;
@end
@implementation SendMediaPlayerView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
     
//        self.topImageView.backgroundColor = [UIColor redColor];
        self.bottomImageView = [[UIImageView alloc]init];
//        self.bottomImageView.backgroundColor = [UIColor redColor];
        self.bottomImageView.userInteractionEnabled = YES;
        
        self.startBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 7,30,30)];
        [self.startBtn setImage:[UIImage imageNamed:@"video_play"] forState:UIControlStateNormal];
        [self.startBtn setImage:[UIImage imageNamed:@"video_stop"] forState:UIControlStateSelected];
//        self.startBtn.backgroundColor = [UIColor redColor];
        
//        self.fullScreenBtn = [[UIButton alloc]init];
////        self.fullScreenBtn.backgroundColor = [UIColor redColor];
//        [self.fullScreenBtn setImage:[UIImage imageNamed:@"kr-video-player-fullscreen"] forState:UIControlStateNormal];
        
        self.currentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 15,35, 15)];
        self.currentTimeLabel.text = @"00:00";
        self.currentTimeLabel.textColor = [UIColor whiteColor];
        self.currentTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.currentTimeLabel.font = [UIFont systemFontOfSize:11.0f];
        self.totalTimeLabel = [[UILabel alloc]init];
        self.totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.totalTimeLabel.font = [UIFont systemFontOfSize:11.0f];
        self.totalTimeLabel.textColor = [UIColor whiteColor];
        self.totalTimeLabel.text = @"00:00";
        
    
        self.progressView = [[UIProgressView alloc]init];
        self.progressView.progressTintColor    = [UIColor whiteColor];
        self.progressView.trackTintColor       = [UIColor whiteColor];
        
//        self.volumeProgress = [[UIProgressView alloc]init];
//        self.volumeProgress.transform = CGAffineTransformMakeRotation(-M_PI);
//        self.volumeProgress.progressTintColor    = [UIColor whiteColor];
//        self.volumeProgress.trackTintColor       = [UIColor whiteColor];
//

        // 设置slider
        self.videoSlider = [[UISlider alloc]init];
        [self.videoSlider setThumbImage:[UIImage imageNamed:@"video_round"] forState:UIControlStateNormal];
        self.videoSlider.minimumTrackTintColor = [UIColor colorWithRed:213/255.0 green:161/255.0 blue:103/255.0 alpha:1];
        self.videoSlider.maximumTrackTintColor = [UIColor whiteColor];
        
      
        [self addSubview:self.bottomImageView];
       

        
        self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.bottomImageView addSubview:self.startBtn];

        [self.bottomImageView addSubview:self.currentTimeLabel];
        [self.bottomImageView addSubview:self.totalTimeLabel];
        [self.bottomImageView addSubview:self.progressView];
        [self.bottomImageView addSubview:self.videoSlider];
        [self addSubview:self.volumeProgress];
        
        [self addSubview:self.activity];
        
        
        
        
        NSError *error;
        
        [[AVAudioSession sharedInstance] setActive:YES error:&error];
        
        // add event handler, for this example, it is `volumeChange:` method
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
        
        
    }
    return self;
}


- (void)volumeChanged:(NSNotification *)notification
{
    // service logic here.
//    NSLog(@"%@",notification.userInfo);
//    NSString *valueStr = notification.userInfo[@"AVSystemController_AudioVolumeNotificationParameter"];
//    self.volumeProgress.progress = [valueStr floatValue];
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
   
    self.bottomImageView.frame = CGRectMake(0,height-40, width, 40);

  
    
   
   
    self.progressView.frame = CGRectMake(92.5,22.5,190,10);
    
    self.totalTimeLabel.frame = CGRectMake(width-75,15,35,15);
    self.videoSlider.frame = CGRectMake(90,17.5,195 ,10);
   
    self.activity.center = CGPointMake(width/2, height/2);
//    self.volumeProgress.bounds = CGRectMake(0, 0,100,30);
//    self.volumeProgress.center = CGPointMake(40,height/2);
    
    

    
    
}



-(void)dealloc
{
    NSLog(@"%s",__func__);
    
[[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
