//
//  HXVideoRecordViewController.m
//  vidoe_audio_record
//
//  Created by huangxiong on 15/12/15.
//  Copyright © 2015年 huangxiong. All rights reserved.
//

#import "HXVideoRecordViewController.h"
#import "ffmpeg.h"
#import "HXTaskDispatch.h"

@interface HXVideoRecordViewController ()<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, strong) NSString *tmpPath;

@end

@implementation HXVideoRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    // 初始化捕获会话
    _captureSession = [[AVCaptureSession alloc] init];
    
    // 设置分辨率
    if ([_captureSession canSetSessionPreset: AVCaptureSessionPreset352x288]) {
        _captureSession.sessionPreset = AVCaptureSessionPreset352x288;
    }
    
    // 获得输入设备
    AVCaptureDevice *captureDevice = [self getCameraDeviceWithPosition: AVCaptureDevicePositionBack];
    
    if (!captureDevice) {
        NSLog(@"后置摄像头坏了");
        return;
    }
    
    NSError *error = nil;
    
    // 输入设备
    _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice: captureDevice error: &error];
    
    // 错误原因
    if (error) {
        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    
    // 输出数据
    _captureStillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    // 设置输出格式
    [_captureStillImageOutput setOutputSettings: @{AVVideoCodecKey : AVVideoCodecJPEG}];
    
    // 将输入输出添加到会话中
    if ([_captureSession canAddInput: _captureDeviceInput]) {
        [_captureSession addInput: _captureDeviceInput];
    }
    
    if ([_captureSession canAddOutput: _captureStillImageOutput]) {
        [_captureSession addOutput: _captureStillImageOutput];
    }
    
    _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession: _captureSession];
    
    _videoViewContainer.layer.masksToBounds = YES;
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    _videoViewContainer = [[UIView alloc] initWithFrame: CGRectMake(0, 20, rect.size.width, rect.size.height - 100)];
    _videoViewContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: _videoViewContainer];
    
    
    _captureVideoPreviewLayer.frame = _videoViewContainer.bounds;
    _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_videoViewContainer.layer addSublayer: _captureVideoPreviewLayer];
    
    [_captureSession startRunning];
    
    _tmpPath = [NSString stringWithFormat: @"%@/tmp", NSHomeDirectory()];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AVCaptureDevice *) getCameraDeviceWithPosition: (AVCaptureDevicePosition) position {
    
    NSArray<AVCaptureDevice *> *cameras = [AVCaptureDevice devicesWithMediaType: AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in cameras) {
        
        if (device.position == position) {
            return device;
        }
    }
    
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated: YES completion:^{
        
    }];
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    // 根据输出获得链接
    AVCaptureConnection *captureConnection = [_captureStillImageOutput connectionWithMediaType: AVMediaTypeVideo];
    
    // 根据链接获得输出内容
    [_captureStillImageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
        if (imageDataSampleBuffer) {
            NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation: imageDataSampleBuffer];
            
            UIImage *image = [UIImage imageWithData: data];
            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
            NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey: @"count"];
            
            NSString *jpgFile = [NSString stringWithFormat: @"%@/%@.jpg", _tmpPath, @(count)];
            [data writeToFile: jpgFile atomically: YES];
            
            NSString *pngFile = [NSString stringWithFormat: @"%@/%@.png", _tmpPath, @(count)];
            
            NSString *string = [NSString stringWithFormat: @"ffmpeg -i %@ %@", jpgFile, pngFile];
            
            [[HXTaskDispatch shareTaskDispatch] addTask: string finished:^(BOOL finished) {
                
            }];
            
            count++;
            [[NSUserDefaults standardUserDefaults] setInteger: count forKey: @"count"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    }];
}

- (IBAction)videoRecord:(UIButton *)sender {
    

    
    AVCaptureDevice *audioDevice = [[AVCaptureDevice devicesWithMediaType: AVMediaTypeAudio] firstObject];
    
    _audioInput = [[AVCaptureDeviceInput alloc] initWithDevice: audioDevice error: nil];
    
    _captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    [_captureSession stopRunning];
    
    [_captureSession beginConfiguration];
    
    [_captureSession removeOutput: _captureStillImageOutput];
    
    if ([_captureSession canAddInput: _audioInput]) {
        [_captureSession addInput: _audioInput];
    }
    
    AVCaptureConnection *captureConnection=[_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    
    if ([captureConnection isVideoStabilizationSupported ]) {
        captureConnection.preferredVideoStabilizationMode=AVCaptureVideoStabilizationModeAuto;
    }
    
    if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
        [_captureSession addOutput:_captureMovieFileOutput];
    }
    
    [_captureSession commitConfiguration];
    
    [_captureSession startRunning];
    
    NSString *movFile = [NSString stringWithFormat: @"%@/ffmov.mp4", _tmpPath];
    
    [_captureMovieFileOutput startRecordingToOutputFileURL: [NSURL fileURLWithPath: movFile] recordingDelegate: self];
    
    [NSTimer scheduledTimerWithTimeInterval: 15.0 target: self selector: @selector(stopRecordingVideo) userInfo: nil repeats: NO];
}

- (IBAction)flashlight:(UIButton *)sender {
}

- (IBAction)changeCamera:(UIButton *)sender {
    AVCaptureDevice *currentDevice = _captureDeviceInput.device;
    AVCaptureDevicePosition currentPosition = currentDevice.position;
    
    if (currentPosition == AVCaptureDevicePositionBack) {
        currentPosition = AVCaptureDevicePositionFront;
    } else {
        currentPosition = AVCaptureDevicePositionBack;
    }
    
    currentDevice = [self getCameraDeviceWithPosition: currentPosition];
    
    AVCaptureDeviceInput *tempDeviceIput = [[AVCaptureDeviceInput alloc] initWithDevice: currentDevice error: nil];

    
    [_captureSession beginConfiguration];
    
    [_captureSession removeInput: _captureDeviceInput];
    
    if ([_captureSession canAddInput: tempDeviceIput]) {
        [_captureSession addInput: tempDeviceIput];
        _captureDeviceInput = tempDeviceIput;
    }
    
    [_captureSession commitConfiguration];
    
}

- (void) stopRecordingVideo {
    [_captureMovieFileOutput stopRecording];
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error {
    
    NSFileManager *filemanager = [NSFileManager defaultManager];

    NSString *filePath = [[outputFileURL.absoluteString componentsSeparatedByString: @"://"] lastObject];
    
    
    if ([filemanager fileExistsAtPath:filePath]){
        
        NSDictionary *diction = [filemanager attributesOfItemAtPath:filePath error:nil];
        NSLog(@"%@ MB", @([diction fileSize] / 1024 / 1024));
        
        NSString *movFile = filePath;
        
        NSString *mp4File = [NSString stringWithFormat: @"%@/ffmp4.mov", _tmpPath];
        
        NSString *string = [NSString stringWithFormat: @"ffmpeg -y -i %@ -acodec copy %@", movFile, mp4File];
        
        self.view.userInteractionEnabled = NO;
        
        
        [[HXTaskDispatch shareTaskDispatch] addTask: string finished:^(BOOL finished) {
            
            self.view.userInteractionEnabled = YES;
            NSDictionary *diction = [filemanager attributesOfItemAtPath:mp4File error:nil];
            NSLog(@"%@ MB %@KB", @([diction fileSize] / 1024 / 1024), @([diction fileSize] / 1024 % 2014));
        }];
        
    }

    
//    [HXTaskDispatch shareTaskDispatch] [addTask: @"" finished:^(BOOL finished) {
//        
//    }];
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections {
    
}





@end
