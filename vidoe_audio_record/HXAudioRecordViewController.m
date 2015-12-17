//
//  HXAudioRecordViewController.m
//  vidoe_audio_record
//
//  Created by huangxiong on 15/12/15.
//  Copyright © 2015年 huangxiong. All rights reserved.
//

#import "HXAudioRecordViewController.h"
#import "HXSlideView.h"

@interface HXAudioRecordViewController ()

@property (nonatomic, strong) HXSlideView *slideView;

@property (nonatomic, strong) UILabel *progressLabel;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *tmpPath;

@property (nonatomic, strong) NSTimer * timer;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, assign) NSInteger hour;

@property (nonatomic, assign) NSInteger minute;

@property (nonatomic, assign) NSInteger second;

@property (nonatomic, assign) NSInteger duration;
@end

@implementation HXAudioRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _slideView = [[HXSlideView alloc] initWithFrame: CGRectMake(0, 100, 320, 20) andSlideType: kHXSlideViewTypeDefault];
    
    
    [_slideView setSelectColor: UIColorFromRGB(0x2DB0FB)];
    
    [_slideView setIndicatorColor: UIColorFromRGB(0x2DB0FB)];
    
    [_slideView setUnSelectColor: UIColorFromRGB(0xF1F1F1)];
    
    [_slideView setProgressValue: 50];
    [self.view addSubview: _slideView];
    
    [self setAudioSession];
    
    _count = 0;
    
    _tmpPath = [NSString stringWithFormat: @"%@/tmp", NSHomeDirectory()];
    
}

- (void) setAudioSession {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 设置音频会话
    [session setCategory: AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionAllowBluetooth error: nil];
    
    // 激活
    [session setActive: YES error: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (AVAudioRecorder *)audioRecorder {
    
    if (_audioRecorder == nil) {
        
        NSString *filePath = [NSString stringWithFormat: @"%@/%@.m4a", _tmpPath, @(_count)];
        
        // 直接这样写 key : value, 不是 value : key
        // 不是 setValue forKey
        NSDictionary *dic = @{
                              // 录音格式
                              AVFormatIDKey : @(kAudioFormatMPEG4AAC),
                              // 采样频率
                              AVSampleRateKey : @(44100.0),
                              // 声道
                              AVNumberOfChannelsKey :  @(2),
                              // 每个采样点位数
                              AVLinearPCMBitDepthKey : @(16),
                              // 浮点采样
                              AVLinearPCMIsFloatKey : @(YES),
                              // 音视频交叉
                              AVLinearPCMIsNonInterleaved : @(YES),
                              
                              AVEncoderAudioQualityKey : @(AVAudioQualityHigh)
                              
                              // AVLinearPCMIsBigEndianKey 表示是否大端模式
                              
                              // AVEncoderAudioQualityKey 采样质量 从这里面选 AVAudioQuality
                              
                              // ....
                              
                              };
        
        NSLog(@"%@", dic);
     
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL: [NSURL fileURLWithPath: filePath] settings: dic error: &error];
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        
//        NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
//        //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
//        [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
//        //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
//        [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
//        //录音通道数  1 或 2
//        [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
//        //线性采样位数  8、16、24、32
//        [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
//        //录音的质量
//        [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
//        
//        NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lll.aac", strUrl]];
    //    urlPlay = url;
        
//        NSLog(@"%@", recordSetting);
        
//        NSError *error;
//        //初始化
//        _audioRecorder = [[AVAudioRecorder alloc]initWithURL: [NSURL fileURLWithPath: filePath] settings:recordSetting error:&error];
//        //开启音量检测
//        _audioRecorder.meteringEnabled = YES;
//        _audioRecorder.delegate = self;
    }
    return _audioRecorder;
}

- (AVAudioPlayer *)audioPlayer {
    

    if (!_audioPlayer) {
        NSString *filePath = [NSString stringWithFormat: @"%@/%@.m4a", _tmpPath, @(_count)];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if ([fileManager fileExistsAtPath: filePath]) {
            NSDictionary *dict = [fileManager attributesOfItemAtPath: filePath error: nil];
            NSLog(@"%@", dict);
            NSLog(@"文件大小 : %@ MB %@ KB", @([dict fileSize] / 1024 / 1024), @([dict fileSize] / 1024 % 1024));
        }
        
        NSError *error = nil;
        
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath: filePath] error: &error];
        
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    
    return _audioPlayer;
}

- (IBAction)playAudio:(UIButton *)sender {
    
    [self.audioPlayer play];
    
     NSInteger timeCount = _hour * 3600 + _minute * 60 + _second;
    
    _duration = self.audioPlayer.duration;
    _hour = 0, _minute = 0, _second = 0;
    [_timer setFireDate: [NSDate distantPast]];
    
}

- (IBAction)recordAudio:(UIButton *)sender {

    // 开始录制
    [self.audioRecorder record];
    self.audioRecorder.delegate = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(handleTimer) userInfo: nil repeats: YES];
    
//    [_timer fire];
    // 共生模式
    [[NSRunLoop mainRunLoop] addTimer: _timer forMode: NSRunLoopCommonModes];
}

- (void) handleTimer {

    _second++;
    
    if (_second == 60) {
        _minute++;
        _second = 0;
    }
    
    if (_minute == 60) {
        _hour++;
        _minute = 0;
    }
    
    if (_hour == 24) {
        _hour = 0;
    }
    
    _timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", _hour, _minute, _second];
    
    if (_duration) {
        
        NSInteger sum = _hour * 3600 + _minute * 60 + _second;
        [_slideView setProgressValue: sum * 100 / _duration];
        
    }
    
}

- (IBAction)pauseRecord:(UIButton *)sender {
    
    // 暂停
    [self.audioRecorder pause];
    
    _timer.fireDate = [NSDate distantFuture];
}

- (IBAction)resumeRecord:(UIButton *)sender {
    // 恢复和开始录制一样
    [self.audioRecorder record];
    _timer.fireDate = [NSDate distantPast];
}

- (IBAction)stopRecord:(UIButton *)sender {
    
    // 停止录制
    [self.audioRecorder stop];
    
    // 暂停
    [_timer setFireDate: [NSDate distantFuture]];

    
    NSInteger timeCount = _hour * 3600 + _minute * 60 + _second;
    
    NSInteger count = self.audioRecorder.currentTime;
    
    if (self.audioRecorder.currentTime) {

    }
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    
}
@end
