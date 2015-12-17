//
//  ViewController.m
//  vidoe_audio_record
//
//  Created by huangxiong on 15/12/15.
//  Copyright © 2015年 huangxiong. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视频音频录制";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"返回" style: UIBarButtonItemStylePlain target: nil action: nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playVideio:(UIButton *)sender {
    
    NSString *tmpPath = [NSString stringWithFormat: @"%@/tmp", NSHomeDirectory()];
    
    NSString *filePath = [NSString stringWithFormat: @"%@/ffmov.mov", tmpPath];
    
    MPMoviePlayerViewController *conroller = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath: filePath]];
    
    
    [self presentViewController: conroller animated: YES completion:^{
        
    }];
}

- (IBAction)playMp4File:(UIButton *)sender {
    NSString *tmpPath = [NSString stringWithFormat: @"%@/tmp", NSHomeDirectory()];
    
    NSString *filePath = [NSString stringWithFormat: @"%@/ffmp4.mp4", tmpPath];
    
    MPMoviePlayerViewController *conroller = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath: filePath]];
    
    
    [self presentViewController: conroller animated: YES completion:^{
        
    }];
}
@end
