//
//  ViewController.m
//  VideoSelection
//
//  Created by syqaxldy on 2020/4/2.
//  Copyright © 2020 syqaxldy. All rights reserved.
//
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight ([UIScreen mainScreen].bounds.size.height)
#import "ViewController.h"
#import "SendMediaView.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ChooseVideoCollectionCell.h"
#import "ChooseVideoModel.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,retain)SendMediaView *player;
@property(nonatomic,strong) NSMutableArray *timeArr;
@property(nonatomic,strong) NSMutableArray *imageArr;
@property(nonatomic,strong) NSMutableArray *urlArr;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;
// 选中cell的indexPath
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
// 取消选中的cell，防止由于重用，在取消选中的代理方法中没有设置
@property (nonatomic, strong) NSIndexPath *DeselectIndexpath;
@end

@implementation ViewController
-(NSMutableArray *)urlArr
{
    if (!_urlArr) {
        _urlArr = [NSMutableArray array];
    }
    return _urlArr;
}
-(NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
-(NSMutableArray *)timeArr
{
    if (!_timeArr) {
        _timeArr = [NSMutableArray array];
    }
    return _timeArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
     self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.view addSubview:self.collectionView];
    [self getVideo];
}
-(void)getVideo
{
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
     options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
     PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
     // 这时 assetsFetchResults 中包含的，应该就是各个资源（PHAsset）
     for (NSInteger i = 0; i < assetsFetchResults.count; i++) {
         // 获取一个资源（PHAsset）
         PHAsset *phAsset = assetsFetchResults[i];
         if (phAsset.mediaType == PHAssetMediaTypeVideo) {
             PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
             options.version = PHImageRequestOptionsVersionCurrent;
             options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
             options.networkAccessAllowed = YES;
             PHImageManager *manager = [PHImageManager defaultManager];
             [manager requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                 if (asset && [asset isKindOfClass:[AVURLAsset class]]) {
                     AVURLAsset *urlAsset = (AVURLAsset *)asset;
                        
                        NSURL *url = urlAsset.URL;
                     
                       
                        NSString *urlStr = [[url absoluteString] substringFromIndex:7];
                       
                        NSDictionary *dicc = [self getVideoInfoWithSourcePath:urlStr];
                                         
                        UIImage *image =[self firstFrameWithVideoURL:url size:CGSizeMake(kWidth, kWidth)];
                          NSString *timeStr =[dicc objectForKey:@"duration"];
                        [self.timeArr addObject:timeStr];
                        [self.urlArr addObject:urlStr];
                        [self.imageArr addObject:image];
                       
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                             [self.collectionView reloadData];
                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                            
                            [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
                            [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
                           NSString *str = [NSString stringWithFormat:@"%@",self.urlArr[0]];
                              
                               self->_player.videoURL = [NSURL fileURLWithPath:str isDirectory:YES];
                        });
                 }
                  
              
             }];
         }
     }
        self->_player = [[SendMediaView alloc]initWithFrame:CGRectMake(0, 88, kWidth, 300)];
      
            [self.view addSubview:self->_player];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    view.layer.zPosition = 0.0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.timeArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChooseVideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseVideoCollectionCell" forIndexPath:indexPath];
    cell.timeLabel.text = self.timeArr[indexPath.row];
    cell.imageV.image = self.imageArr[indexPath.row];
    
    if ([self.selectIndexPath isEqual:indexPath]) {
       
        cell.selectView.hidden = NO;
    } else {
         cell.selectView.hidden = YES;
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectIndexPath = indexPath;
    ChooseVideoCollectionCell *cell = (ChooseVideoCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectView.hidden = NO;
     NSString *str = [NSString stringWithFormat:@"%@",self.urlArr[indexPath.row]];
   
    self.player.videoURL = [NSURL fileURLWithPath:str isDirectory:YES];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.DeselectIndexpath = indexPath;
    ChooseVideoCollectionCell *cell = (ChooseVideoCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell == nil) { // 如果重用之后拿不到cell,就直接返回
        return;
    }
   cell.selectView.hidden = YES;
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ChooseVideoCollectionCell *chooseCell = (ChooseVideoCollectionCell *)cell;
    if (self.DeselectIndexpath && [self.DeselectIndexpath isEqual:indexPath]) {
        
        chooseCell.selectView.hidden = NO;
    }
    
    if ([self.selectIndexPath isEqual:indexPath]) {
         chooseCell.selectView.hidden = NO;
    }
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        NSLog(@"%f",20*WIDTH_RATIO);
//           layout.sectionInset = UIEdgeInsetsMake(0 ,0, 0,0);
          _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 388, kWidth, kHeight-300) collectionViewLayout:self.layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor blackColor];
        [_collectionView registerClass:[ChooseVideoCollectionCell class] forCellWithReuseIdentifier:@"ChooseVideoCollectionCell"];

       
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
            _layout = [UICollectionViewFlowLayout new];
            _layout.minimumLineSpacing = 1;
            _layout.minimumInteritemSpacing = 1;
            _layout.itemSize = CGSizeMake((kWidth-3)/4, (kWidth-3)/4);
//            _layout.sectionInset = UIEdgeInsetsMake(0 ,0 , 45,0);
        }
        return _layout;
   
}
-(void)dealloc
{
   
    [self.urlArr removeAllObjects];
  
    NSLog(@"%s",__func__);
    
}
- (NSDictionary *)getVideoInfoWithSourcePath:(NSString *)path{
    AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
    CMTime   time = [asset duration];
    int seconds = ceil(time.value/time.timescale);

    NSInteger   fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil].fileSize;

    //format of minute
           NSString *str_minute = [NSString stringWithFormat:@"%d",seconds/60];
           //format of second
           NSString *str_second = [NSString stringWithFormat:@"%.2d",seconds%60];
           //format of time
           NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
          
    
    return @{@"size" : @(fileSize),
             @"duration" : format_time};
}
- (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size
{
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    
    {
        return [UIImage imageWithCGImage:img];
    }
    CGImageRelease(img);
    return nil;
}
@end
