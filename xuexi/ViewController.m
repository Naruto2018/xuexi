//
//  ViewController.m
//  xuexi
//
//  Created by NarutoMac on 2017/11/14.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "ViewController.h"
#import "View02.h"
#import "View03.h"
#import "View04.h"
#import "View05.h"
#import "View06.h"
#import "View07.h"

@interface ViewController ()

@end

@implementation ViewController

//属性和成员变量的同步
@synthesize Timeview = _Timeview;
@synthesize t = _t;
@synthesize t2 = _t2;

- (void)anniu {
    UIButton* b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b.frame = CGRectMake(100, 20, 100, 40);
    [b setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [b setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    
    [b setTitle:@"启动定时器" forState:UIControlStateNormal];
    [b setTitle:@"哈哈" forState:UIControlStateHighlighted];
    
    [b setBackgroundColor:[UIColor blackColor]];
    
    b.titleLabel.font = [UIFont systemFontOfSize:15];
    //按钮添加事件
    // 谁来实现事件函数                     @selector(hanshu) 执行函数               事件类型
    //UIControlEventTouchUpInside 当手指离开屏幕时并且手指的位置在按钮范围内触发
    [b addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    //UIControlEventTouchDown 手指碰到屏幕上时
    //[b addTarget:self action:@selector(hanshu2) forControlEvents:UIControlEventTouchDown];
    
    UIButton* d = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [d setTitle:@"停止定时器" forState:UIControlStateNormal];
    d.frame = CGRectMake(200, 20, 100, 40);
    [d setBackgroundColor:[UIColor whiteColor]];
    [d addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮识别ID,tag最好从100开始
    b.tag = 101;
    d.tag = 102;
    
    UIButton* e = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [e setTitle:@"进入页面" forState:UIControlStateNormal];
    [e setBackgroundColor:[UIColor whiteColor]];
    e.frame = CGRectMake(100, 450, 100, 40);
    [e addTarget:self action:@selector(inv3) forControlEvents:UIControlEventTouchUpInside];
    
    _t = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_t setTitle:@"进入页面4" forState:UIControlStateNormal];
    [_t setBackgroundColor:[UIColor whiteColor]];
    _t.frame = CGRectMake(210, 450, 100, 40);
    [_t addTarget:self action:@selector(inv4) forControlEvents:UIControlEventTouchUpInside];
    
    _t2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_t2 setTitle:@"进入页面5" forState:UIControlStateNormal];
    [_t2 setBackgroundColor:[UIColor whiteColor]];
    _t2.frame = CGRectMake(100, 500, 100, 40);
    [_t2 addTarget:self action:@selector(inv5) forControlEvents:UIControlEventTouchUpInside];
    
    _t3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_t3 setTitle:@"进入页面6" forState:UIControlStateNormal];
    [_t3 setBackgroundColor:[UIColor whiteColor]];
    _t3.frame = CGRectMake(210, 500, 100, 40);
    [_t3 addTarget:self action:@selector(inv6) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:b];
    [self.view addSubview:d];
    [self.view addSubview:e];
    [self.view addSubview:_t];
    [self.view addSubview:_t2];
    [self.view addSubview:_t3];
}

//开始
- (void)start {
    //NSTimer的类方法创建一个定时器并且启动
    //1 每隔多长时间 调用定时器 秒 整数
    //2 定时器函数的对象
    //3 定时器函数
    //4 传入定时器函数里一个参数 无参数传NIL
    //5 定时器是否重复操作 YES 重复 NO 完成一次
    //返回值为一个新建好的定时器
    _Timeview = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(dosomesing:) userInfo:@"鸣人" repeats:YES];
    NSLog(@"开始");
}

- (void)dosomesing:(NSTimer*) d{
    NSLog(@"时间到啦 %@",d.userInfo);
    UIView* v = [self.view viewWithTag:108];
    v.frame = CGRectMake(v.frame.origin.x+5, v.frame.origin.y+5, 200, 200);
    
}

//停止
- (void)stop {
    if (_Timeview != nil) {
        //停止定时器
        [_Timeview invalidate];
    }
    
    NSLog(@"停止");
}

- (void)hanshu2 {
    NSLog(@"蹦到了");
}
    
- (void)hanshu:(UIButton*) btn{
    if(btn.tag == 101){
        NSLog(@"按钮1按下了");
    }
    if(btn.tag == 102){
        NSLog(@"按钮2按下了");
    }
}

- (void)label {
    //对象
    UILabel* l = [[UILabel alloc] init];
    //设置文字位置
    l.frame = CGRectMake(20, 80, 200, 100);
    //设置文字
    //[l setText:@"我是文字\n我是文字2"];
    
    //设置字体
    l.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    //设置文字的对其
    l.textAlignment = NSTextAlignmentCenter;
    
    NSString *str1 = @"我是文字\n我是文字2";
    
    //http://blog.csdn.net/u013346305/article/details/50896308
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10;// 字体的行间距
    style.firstLineHeadIndent = 20.0f;//首行缩进
    style.alignment = NSTextAlignmentLeft;//
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:str1];
    
    //设置段落
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30.0f] range:NSMakeRange(0, 4)];
    [str2 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(5, 5)];

    
    l.attributedText = str2;
    
    //设置文字颜色
    [l setTextColor:[UIColor blackColor]];
    //设置LABEL的背景颜色
    [l setBackgroundColor:[UIColor whiteColor]];
    //设置文字大小
    //l.font = [UIFont systemFontOfSize:30];
    
    //画园角
    l.layer.cornerRadius = 25;
    l.layer.masksToBounds = YES;
    
    //设置自动换行
    l.numberOfLines = 0;
    
    [self.view addSubview:l];
    
}

//当视图控制器第一次加载显示视图时 调用
//布局 初始化视图 初始化资源使用
- (void)viewDidLoad {
    //调用父亲类的加载视图函数
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //UITabBarItem* tab = [[UITabBarItem alloc] initWithTitle:@"111" image:nil tag:302];
    
    //根据系统风格创建
//    NSString* imgstr = @"f1.png";
//    
//    UIImage* img = [[UIImage imageNamed:imgstr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UITabBarItem* tab = [[UITabBarItem alloc] initWithTitle:nil image:img tag:3];
//    
//    //按钮右上角提示信息
//    tab.badgeValue = @"200";
//    //提示信息颜色
//    tab.badgeColor = [UIColor redColor];
//    
//    tab.imageInsets = UIEdgeInsetsMake(5,0, -5,0);
//    
//    self.navigationController.tabBarItem = tab;

    
    
    //uiview 是IOS 视图对象
    //屏幕能看到的UI对象 都是UIVIEW子类 所有屏幕对象的基础类
    //UIVIEW 是矩形对象
    UIView* v = [[UIView alloc] init];
    UIView* v2 = [[UIView alloc] init];
    UIView* v3 = [[UIView alloc] init];
    
    //X 往右 Y 往下
    v.frame = CGRectMake(50, 190, 200, 200);
    [v setBackgroundColor:[UIColor blueColor]];
    
    v2.frame = CGRectMake(75, 215, 200, 200);
    [v2 setBackgroundColor:[UIColor greenColor]];
    
    v3.frame = CGRectMake(100, 240, 200, 200);
    [v3 setBackgroundColor:[UIColor orangeColor]];
    //1 将视图显示在屏幕上
    //2 将视图做为父亲视图的子视图管理起来
    //3 哪个视图先添加到父亲视图中 就先绘制哪个视图
    //4 哪个视图最后添加 就最后绘制哪个
    [self.view addSubview:v];
    [self.view addSubview:v2];
    [self.view addSubview:v3];
    
    //将指定UIVIEW视图对象 调整到最前面显示
    //会改变绘制顺序变为最后添加
    [self.view bringSubviewToFront:v];//2
    
    //将指定UIVIEW视图对象 调整到最后面显示
    //会改变绘制顺序变为第一添加
    [self.view sendSubviewToBack:v3];//0
    
    //subviews管理所有self.view的子视图数组    
    UIView* b = self.view.subviews[0];
    UIView* f = self.view.subviews[2];
    UIView* e = self.view.subviews[1];
    
    if (b == v3){
        NSLog(@"b=v3");
    }
    
    if (e == v2){
        NSLog(@"e=v2");
    }
    
    if (f == v){
        NSLog(@"f=v");
    }
    
    v.tag = 108;
    
    
    
    NSArray *subviews = [self.view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return; // COUNT CHECK LINE
    
    for (UIView *subview in subviews) {
        
        // Do what you want to do with the subview
        NSLog(@"%@", subview);
        
        // List the subviews of subview
    }
    

    
    //是否隐藏 默认显示
    v.hidden = NO;
    //设置透明度
    //1不透明 0透明 0.5 半透明
    v.alpha = 0.8;
    
    //是否显示不透明
    v.opaque = YES;
    
    //将自己从父亲视图删除
    //1 从父视图管理中删除
    //2 不在显示在屏幕上
    //[v removeFromSuperview];
    NSLog(@"第一次加载视图");
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]]];
    
    //设置导航透明度
    //默认透明度为YES 可透明的
    //使导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //导航颜色
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    //设置导航栏风格颜色 UIBarStyleBlack 黑色
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    //设置导航元素项目按钮风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    
    //显示工具栏对象  默认YES
    self.navigationController.toolbarHidden = NO;
    
    //工具栏透明度
    self.navigationController.toolbar.translucent = NO;
    
    UIImage* barimg1 = [[UIImage imageNamed:@"f1.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem* barbtn1 = [[UIBarButtonItem alloc] initWithImage:barimg1 style:UIBarButtonItemStylePlain target:self action:@selector(inv7bar)];
    
    UIBarButtonItem* barbtn2 = [[UIBarButtonItem alloc] initWithTitle:@"文字" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIBarButtonItem* barbin3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    
    //固定宽度分割占位按钮
    UIBarButtonItem* barf1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    //创建自动计算宽度按钮
    UIBarButtonItem* barf2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    barf1.width = 100;
    
    NSArray* arrryBtn = [NSArray arrayWithObjects:barbtn1,barf2,barbtn2,barf2,barbin3, nil];
    
    self.toolbarItems = arrryBtn;
    
    //self.title = @"";
    
    UIBarButtonItem* next = [[UIBarButtonItem alloc] initWithTitle:@"页面6" style:UIBarButtonItemStylePlain target:self action:@selector(inv6bar)];
    
    //next.tintColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = next;

    [self anniu];
    [self label];
    //[self playsp];
}

//当视图控制器的视图即将显示时调用
//视图分为 显示前 正在处于显示状态 被隐藏
//参数 表示是否用后动画切换后显示
//每次视图显示都会调用
- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear 即将显示");
}

//当视图即将消失时调用
//参数 表示是否用动画切换后显示
//当前视图状态 还显示在屏幕上
- (void) viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear 即将消失");
}

//当时视图已经显示到屏幕瞬间调用
//参数 表示是否用动画切换后显示
//当前状态 已经显示到屏幕上
- (void) viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear 已经显示");
}

//当视图已经消失从屏幕上
//参数 表示是否用动画切换后显示
//当前状态 视图控制器已经消失从屏幕上
- (void) viewDidDisappear:(BOOL)animated{
    NSLog(@"viewDidDisappear 已经消失");
}

- (void) playsp {
    NSURL *url = [NSURL URLWithString:@"http://play.mkangou.com/hd/1117shou.mp4"];
    
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    //playerLayer.frame = CGRectMake(0, 300, 360, 300);
    playerLayer.frame = self.view.layer.bounds;
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.view.layer addSublayer:playerLayer];
    
    [player play];
}

//当屏幕被点击时调用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//  MPMoviePlayerController
    //播放视频文件地址
//    NSString* strUrl = @"http://mkangou.oss-cn-shanghai.aliyuncs.com/hd/1117shou.mp4";
//    //将字符串地址转为网址
//    NSURL* url = [NSURL URLWithString:strUrl];
    
//    _playerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
//
//    _playerController.view.frame = CGRectMake(0, 300, 370, 300);
//
//    [_playerController prepareToPlay];
    
//    [self.view addSubview:_playerController.view];
    
    //AVPlayer
    //播放视频文件地址
//    NSURL *url = [NSURL URLWithString:@"http://mkangou.oss-cn-shanghai.aliyuncs.com/hd/1117shou.mp4"];
//
//    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:url options:nil];
//
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
//
//    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
//
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//
//    //playerLayer.frame = CGRectMake(0, 300, 360, 300);
//    playerLayer.frame = self.view.layer.bounds;
//
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//
//    //[self.view.layer addSublayer:playerLayer];
//
//    [player play];
    
    View02* v2 = [[View02 alloc] init];
    
    //显示一个新视图控制器当屏幕上
    //1 新视图控制器对象
    //2 是否使用动画切换效果
    //3 切换结束后功能调用，不需要传NIL即可
    [self presentViewController:v2 animated:YES completion:nil];
    
}

- (void) inv3{
    View03* v3 = [[View03 alloc] init];
    [self presentViewController:v3 animated:YES completion:nil];
}

- (void) inv4{
    View04* v4 = [[View04 alloc] init];
    [self presentViewController:v4 animated:YES completion:nil];
}

-(void) inv5{
    View05* v5 = [[View05 alloc] init];
    [self presentViewController:v5 animated:YES completion:nil];
}

//当内存过低时 会发起警告信息 调用
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"警告 内存过低!");
}

-(void) inv6{
    View06* v6 = [[View06 alloc] init];
    [self presentViewController:v6 animated:YES completion:nil];
}

-(void) inv6bar{
    View06* v6 = [[View06 alloc] init];
    [self.navigationController pushViewController:v6 animated:YES];
}

-(void) inv7bar{
    View07* v7 = [[View07 alloc] init];
    [self.navigationController pushViewController:v7 animated:YES];
}
@end
