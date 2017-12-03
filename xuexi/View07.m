//
//  View07.m
//  xuexi
//
//  Created by 鸣人 on 2017/11/27.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "View07.h"

typedef struct Wavehead
{
    /****RIFF WAVE CHUNK*/
    unsigned char a[4];     //Four bytes: 'R','I','F','F'
    long int b;             //Size of Chunk
    unsigned char c[4];     //Four bytes: 'W','A','V','E'
    /****RIFF WAVE CHUNK*/
    /****Format CHUNK*/
    unsigned char d[4];     //Four bytes: 'f','m','t',''
    long int e;             //16: no additional information，18: additional information；
    short int f;            //encoding mode，default,0x0001;
    short int g;            //channel，1:mono，2:stereo;
    int h;                  //sample rate;
    unsigned int i;         //bytes per second;
    short int j;            //bytes per sample;
    short int k;            //bitDepth
    /****Format CHUNK*/
    /***Data Chunk**/
    unsigned char p[4];     //Four bytes: 'd','a','t','a'
    long int q;             //length of audio data, not include WAV head
} WaveHead;//Structure of WAV head

@interface View07 ()
@property (nonatomic,strong) NSMutableData *pcmData;
@end

@implementation View07

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //屏幕不锁定
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", @"5a03b4f9"];
    [IFlySpeechUtility createUtility:initString];
    
    //获取语音合成单例
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    //设置协议委托对象
    _iFlySpeechSynthesizer.delegate = self;
    //设置合成参数
    //设置在线工作方式
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                  forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //设置音量，取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"100"
                                  forKey: [IFlySpeechConstant VOLUME]];
    //发音人，默认为”xiaoyan”，可以设置的参数列表可参考“合成发音人列表”
    [_iFlySpeechSynthesizer setParameter:@"x_liying_Actor"
                                  forKey: [IFlySpeechConstant VOICE_NAME]];
    //设置语速
    [_iFlySpeechSynthesizer setParameter:@"60"
                                  forKey: [IFlySpeechConstant SPEED]];
    //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
    [_iFlySpeechSynthesizer setParameter:nil
                                  forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    
    
    _btnPlay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnPause = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    _btnPlay.frame = CGRectMake(50, 50, 100, 40);
    _btnPause.frame= CGRectMake(150, 50, 100, 40);
    _btnStop.frame= CGRectMake(240, 50, 100, 40);
    
    [_btnPlay setTitle:@"播放" forState:UIControlStateNormal];
    [_btnPause setTitle:@"暂停" forState:UIControlStateNormal];
    [_btnStop setTitle:@"停止" forState:UIControlStateNormal];
    
    [_btnPlay addTarget:self action:@selector(playmusic) forControlEvents:UIControlEventTouchUpInside];
    [_btnPause addTarget:self action:@selector(pausemusic) forControlEvents:UIControlEventTouchUpInside];
    [_btnStop addTarget:self action:@selector(stopmusic) forControlEvents:UIControlEventTouchUpInside];
    
    _musicPv = [[UIProgressView alloc] initWithFrame:CGRectMake(50, 100,  300, 0)];
    
    _musicPv.progress = 0;
    
    _voNo = [[UISwitch alloc] initWithFrame:CGRectMake(50, 150, 50, 50)];
    
    _voNo.on = NO;
    
    [_voNo addTarget:self action:@selector(dovono:) forControlEvents:UIControlEventValueChanged];
    
    _Vol = [[UISlider alloc]  initWithFrame:CGRectMake(130, 135, 200, 50)];
    
    _Vol.maximumValue = 10;
    
    _Vol.minimumValue = 0;
    
    _Vol.value = 10;
    
    [_Vol addTarget:self action:@selector(dovol:) forControlEvents:UIControlEventValueChanged];
    
    _musicJd = [[UISlider alloc] initWithFrame:CGRectMake(50, 220,  300, 50)];
    
    _musicJd.maximumValue = 10;
    
    _musicJd.minimumValue = 0;
    
    _musicJd.value = 0;
    
    [_musicJd addTarget:self action:@selector(kuaijin:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_btnPlay];
    [self.view addSubview:_btnPause];
    [self.view addSubview:_btnStop];
    [self.view addSubview:_musicPv];
    [self.view addSubview:_musicJd];
    [self.view addSubview:_voNo];
    [self.view addSubview:_Vol];
    NSString *strPath=[[NSBundle mainBundle] pathForResource:@"111"ofType:@"txt"];
    
    NSString *str=[[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%lu",str.length);
    currentTrackNumber = str.length / 1000;
    
    _arrayOfTracks = [[NSMutableArray alloc] init];
    for (int i = 0; i<currentTrackNumber; i++) {
        NSString* temp = [str substringToIndex:1000];
        [_arrayOfTracks addObject:temp];
        str =  [str substringFromIndex:1001];
    }
     k = 0;
    
    isplay = NO;
    [self getdata:k];
   
}

-(void)getdata:(int)k{
    _docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"uri.pcm"];
    
    NSString* playstr = [_arrayOfTracks objectAtIndex:k];
    NSString* path = [[NSString alloc] initWithFormat:@"uri%d.pcm", k];
    _filePath = [NSString stringWithFormat:@"%@/%@",_docDirPath,path];
    [_iFlySpeechSynthesizer synthesize:playstr toUri:_filePath];
    
    
}

-(void)playmusic{
    NSLog(@"播放");
    //添加后台播放代码：
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //开始播放
    //[_player play];
    
}

//合成结束
- (void) onCompleted:(IFlySpeechError *) error {
    isplay = YES;
    _audioData = [NSData dataWithContentsOfFile:_filePath];
    [self writeWaveHead:_audioData sampleRate:16000];
     [self cPlayer];
}

-(void)pausemusic{
    NSLog(@"暂停播放");
    
    [_player pause];
}

-(void)stopmusic{
    NSLog(@"停止播放");
    [_player stop];
    
    //当前播放时间归零
    _player.currentTime = 0;
}

-(void)dovol:(UISlider*) sli{
    NSLog(@"改变音量 %f",sli.value);
    
    _player.volume  = sli.value / 10;
}

-(void)dovono:(UISwitch*) swi{
    NSLog(@"静音");
    
    if (swi.on == YES) {
        _player.volume =0;
        swi.selected = YES;
        _Vol.enabled = NO;
    }else if (swi.on == NO){
        _player.volume =_Vol.value / 10;
        swi.selected =  NO;
        _Vol.enabled = YES;
    }
    
    
}

//创建音频控制器
-(void)cPlayer{
    //获取本地资源MP3文件方法
    //NSString* mp3str = [[NSBundle mainBundle] pathForResource:@"Towards.the.Sun" ofType:@"mp3"];
    //NSURL * mp3url = [[NSURL alloc] initFileURLWithPath:mp3str];
    
    //网络播放
//    NSString* mp3str = @"https://www.cathyy.com/Web/Mp3/Towards.the.Sun.mp3";
//
//    NSURL * mp3url = [[NSURL alloc] initWithString:mp3str];
//
//    NSData * audioData = [NSData dataWithContentsOfURL:mp3url];
    
    //将数据保存到本地指定位置
    //检索指定路径
    //第一个参数指定了搜索的路径名称,NSDocumentDirectory表示是在Documents中寻找.NSCacheDirectory的话就是在cache文件中寻找.第二个参数限定了文件的检索范围只在沙箱内部.其意义为用户电脑主目录.也可以修改为网络主机等.最后一个参数决定了是否展开波浪线符号.展开后才是完整路径,这个布尔值一直为YES.
    //该方法返回值为一个数组,在iphone中由于只有一个唯一路径(相对OC而言),所以直接取数组第一个元素即可.
   //NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"uri.pcm"];
   // NSString *filePath = [NSString stringWithFormat:@"%@/%@",docDirPath,@"Temp"];
    //[audioData writeToFile:filePath atomically:YES];
    
    
    
    NSLog(@"%@",_filePath);
    
    //创建音频播放器对象
    //1 文件地址
    //NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    //NSURL * mp3url = [[NSURL alloc] initFileURLWithPath:filePath];
    
    
    //_player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
   // _player = [[AVAudioPlayer alloc] initWithData:audioData error:nil];
    
    //添加后台播放代码：
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    _player = [[AVAudioPlayer alloc] initWithData:self.pcmData error:nil];
    
    _player.delegate = self;
    
   // _audioPlayer = [[PcmPlayer alloc] initWithFilePath:_filePath sampleRate:16000];
    
   
    //准备工作 解码
    [_player prepareToPlay];
    
    //循环次数 -1 无线循环
    //_player.numberOfLoops = -1;
    
    //设置音量
    _player.volume = 1;
    _player.delegate = self;
    
      [_player play];

    //定义一个定时器对象 更新进度条
    _Timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(upDataTime) userInfo:nil repeats:YES];
}

-(void)upDataTime{

    [_musicPv setProgress:_player.currentTime / _player.duration] ;
    [_musicJd setValue:(_player.currentTime / _player.duration) * 10];
}


//当音乐播放完成时 调用
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [_Timer invalidate];
    [_musicPv setProgress:0];
    [_musicJd setValue:0];
    k++;
    [self getdata:k];
}

-(void)kuaijin:(UISlider*)sli{
    NSLog(@"11");
    _player.currentTime = (sli.value / 10 ) *_player.duration;
    [_musicPv setProgress:_player.currentTime / _player.duration] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *
 *  write WAV head for audio data
 *
 */
- (void)writeWaveHead:(NSData *)audioData sampleRate:(long)sampleRate{
    Byte waveHead[44];
    waveHead[0] = 'R';
    waveHead[1] = 'I';
    waveHead[2] = 'F';
    waveHead[3] = 'F';
    
    long totalDatalength = [audioData length] + 44;
    waveHead[4] = (Byte)(totalDatalength & 0xff);
    waveHead[5] = (Byte)((totalDatalength >> 8) & 0xff);
    waveHead[6] = (Byte)((totalDatalength >> 16) & 0xff);
    waveHead[7] = (Byte)((totalDatalength >> 24) & 0xff);
    
    waveHead[8] = 'W';
    waveHead[9] = 'A';
    waveHead[10] = 'V';
    waveHead[11] = 'E';
    
    waveHead[12] = 'f';
    waveHead[13] = 'm';
    waveHead[14] = 't';
    waveHead[15] = ' ';
    
    waveHead[16] = 16;  //size of 'fmt '
    waveHead[17] = 0;
    waveHead[18] = 0;
    waveHead[19] = 0;
    
    waveHead[20] = 1;   //format
    waveHead[21] = 0;
    
    waveHead[22] = 1;   //chanel
    waveHead[23] = 0;
    
    waveHead[24] = (Byte)(sampleRate & 0xff);
    waveHead[25] = (Byte)((sampleRate >> 8) & 0xff);
    waveHead[26] = (Byte)((sampleRate >> 16) & 0xff);
    waveHead[27] = (Byte)((sampleRate >> 24) & 0xff);
    
    long byteRate = sampleRate * 2 * (16 >> 3);;
    waveHead[28] = (Byte)(byteRate & 0xff);
    waveHead[29] = (Byte)((byteRate >> 8) & 0xff);
    waveHead[30] = (Byte)((byteRate >> 16) & 0xff);
    waveHead[31] = (Byte)((byteRate >> 24) & 0xff);
    
    waveHead[32] = 2*(16 >> 3);
    waveHead[33] = 0;
    
    waveHead[34] = 16;
    waveHead[35] = 0;
    
    waveHead[36] = 'd';
    waveHead[37] = 'a';
    waveHead[38] = 't';
    waveHead[39] = 'a';
    
    long totalAudiolength = [audioData length];
    
    waveHead[40] = (Byte)(totalAudiolength & 0xff);
    waveHead[41] = (Byte)((totalAudiolength >> 8) & 0xff);
    waveHead[42] = (Byte)((totalAudiolength >> 16) & 0xff);
    waveHead[43] = (Byte)((totalAudiolength >> 24) & 0xff);
    
    self.pcmData  = [[NSMutableData alloc]initWithBytes:&waveHead length:sizeof(waveHead)];
    [self.pcmData  appendData:audioData];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
