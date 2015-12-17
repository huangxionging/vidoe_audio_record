//
//  HXAudioRecordViewController.h
//  vidoe_audio_record
//
//  Created by huangxiong on 15/12/15.
//  Copyright © 2015年 huangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface HXAudioRecordViewController : UIViewController<AVAudioRecorderDelegate>

/**
 *  录制音频
 */
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;

/**
 *  音频播放器
 */
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

- (IBAction)playAudio:(UIButton *)sender;
- (IBAction)recordAudio:(UIButton *)sender;
- (IBAction)pauseRecord:(UIButton *)sender;
- (IBAction)resumeRecord:(UIButton *)sender;
- (IBAction)stopRecord:(UIButton *)sender;

@end
