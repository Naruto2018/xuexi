//
//  View07.h
//  xuexi
//
//  Created by 鸣人 on 2017/11/27.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import <UIKit/UIKit.h>
//导入音频播放系统库文件
#import <AVFoundation/AVFoundation.h>
#import "iflyMSC/IFlyMSC.h"
#import "PcmPlayer.h"

//https://www.cathyy.com/Web/Mp3/Towards.the.Sun.mp3
@interface View07 : UIViewController<AVAudioPlayerDelegate,IFlySpeechSynthesizerDelegate>{
    UIButton*  _btnPlay;
    UIButton* _btnPause;
    UIButton *  _btnStop;
    
    UIProgressView* _musicPv;
    UISlider* _musicJd;
    UISlider*  _Vol;
    UISwitch* _voNo;
    
    //音频播放器对象
    AVAudioPlayer* _player;
    //定义并声明定时器对象
    NSTimer* _Timer;
    NSTimer* _Timers;
    
    NSUInteger currentTrackNumber;
    NSData *_audioData;
    int k;
    BOOL isplay;
    
}
@property (strong, nonatomic) NSMutableArray *arrayOfTracks; // 这个数组中保存音频的名称
@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *docDirPath;
@end
