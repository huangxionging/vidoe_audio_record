//
//  HXVideoRecordViewController.h
//  vidoe_audio_record
//
//  Created by huangxiong on 15/12/15.
//  Copyright © 2015年 huangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface HXVideoRecordViewController : UIViewController

/**
 *  捕获会话, 负责在输入和输出设备之间传递数据
 */
@property (nonatomic, strong) AVCaptureSession *captureSession;


@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据

@property (nonatomic, strong) AVCaptureDeviceInput *audioInput;

/**
 *  照片输出流
 */
@property (nonatomic, strong) AVCaptureStillImageOutput *captureStillImageOutput;

@property (nonatomic, strong) AVCaptureMovieFileOutput *captureMovieFileOutput;

/**
 *  相机预览层
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (strong, nonatomic) UIView *videoViewContainer;

- (IBAction)cancel:(UIButton *)sender;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)videoRecord:(UIButton *)sender;
- (IBAction)flashlight:(UIButton *)sender;
- (IBAction)changeCamera:(UIButton *)sender;

@end
