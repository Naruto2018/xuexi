//
//  View04.m
//  xuexi
//
//  Created by NarutoMac on 2017/11/23.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "View04.h"

@interface View04 ()

@end

@implementation View04
@synthesize img = _img;
@synthesize imgv = _imgv;
@synthesize tgr = _tgr;
@synthesize tgr2 = _tgr2;
@synthesize pgr = _pgr;
@synthesize rgr = _rgr;
@synthesize pan = _pan;
@synthesize sgr = _sgr;
@synthesize lpg = _lpg;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.img = [UIImage imageNamed:@"1.JPG"];
//    self.imgv = [[UIImageView alloc] init];
//    self.imgv.image = self.img;
    self.imgv = [[UIImageView alloc] initWithImage:self.img];
    self.imgv.frame = CGRectMake(50, 100, 220, 300);
    
    //开启交互事件响应开关
    //YES 可以响应事件
    //NO  不能j接受响应事件 默认NO
    self.imgv.userInteractionEnabled = YES;
    
    //创建一个点击手势对象
    //UITapGestureRecognizer点击手势  识别点击手势事件
    //1 响应事件的拥有者对象
    //2 响应事件的函数
    self.tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tone:)];
    
    //表示手势识别事件的事件类型 几次点击时触发
    //默认为 1
    self.tgr.numberOfTapsRequired = 1;
    
    //表示几个手指点击时触发此事件函数
    //默认为 1
    self.tgr.numberOfTouchesRequired = 1;
    
    //点击事件添加到视图中 视图即可响应事件
    [self.imgv addGestureRecognizer:self.tgr];
    
    self.tgr2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ttwo:)];
    self.tgr2.numberOfTapsRequired = 2;
    self.tgr2.numberOfTouchesRequired = 1;
    [self.imgv addGestureRecognizer:self.tgr2];
    
    //当单击操作遇到双击操作时 单击操作失效
    [self.tgr requireGestureRecognizerToFail:self.tgr2];
    
    //创建一个捏合手势
    self.pgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pgr:)];
    [self.imgv addGestureRecognizer:self.pgr];
    
    //创建一个旋转手势
    self.rgr = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rgr:)];
    [self.imgv addGestureRecognizer:self.rgr];
    
    self.pgr.delegate = self    ;
    self.rgr.delegate = self;
    
    //创建一个平移手势
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imgv addGestureRecognizer:self.pan];
    
    //创建一个滑动手势
    _sgr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swr:)];
    //设定滑动手势接受事件的类型
    //上下左右
    //UISwipeGestureRecognizerDirectionLeft 向左
    //UISwipeGestureRecognizerDirectionRight 向右
    //UISwipeGestureRecognizerDirectionUp 向上
    //UISwipeGestureRecognizerDirectionDown 向下
    _sgr.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
    //移动手势从图像视图中取消
    [self.imgv removeGestureRecognizer:self.pan];
    
    [self.imgv addGestureRecognizer:_sgr];
    
    //创建长按手势
    _lpg = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lpg:)];
    
    //设置长按手势的时间 默认0.5秒
    _lpg.minimumPressDuration = 5;
    
    [self.imgv addGestureRecognizer:_lpg];
    
    [self.view addSubview:self.imgv];
    
    
}

//事件响应函数 手势点击对象
-(void)tone:(UITapGestureRecognizer*) tap{
    NSLog(@"单击操作");
    //获取手势监控的视图对象
    UIImageView* iv = (UIImageView*) tap.view;
    
    //开始动画过程
    [UIView beginAnimations:nil context:nil];
    
    //设置动画过度时间
    [UIView setAnimationDuration:2];
    
    iv.frame = CGRectMake(0, 0, 375, 812);
    
    //结束动画过程
    [UIView commitAnimations];
}

-(void)ttwo:(UITapGestureRecognizer*) tap{
    NSLog(@"双击操作");
    //获取手势监控的视图对象
    UIImageView* iv = (UIImageView*) tap.view;
    
    //开始动画过程
    [UIView beginAnimations:nil context:nil];
    
    //设置动画过度时间
    [UIView setAnimationDuration:1];
    
    iv.frame = CGRectMake(50, 100, 220, 300);
    
    //结束动画过程
    [UIView commitAnimations];
    
}

-(void)pgr:(UIPinchGestureRecognizer*) pin{
    //获取手势监控的视图对象
    UIImageView* iv = (UIImageView*) pin.view;
    
    //对图像视图对象进行矩阵变换计算并赋值
    //transform 变化 表示图形学变化矩阵
    //CGAffineTransformScale 通过缩放的方式产生矩阵
    //1 原来的矩阵
    //2 X方向的缩放比例
    //3 Y方向的缩放比例
    //返回值 新的缩放后的矩阵变化
    iv.transform =  CGAffineTransformScale(iv.transform, pin.scale, pin.scale);
    //将缩放值归为单位值
    //scale = 1 原来的大小
    //scale < 1 缩小
    //scale > 1 放大
    pin.scale = 1;
    
    
}

-(void)rgr:(UIRotationGestureRecognizer*) rot{
    //获取手势监控的视图对象
    UIImageView* iv = (UIImageView*) rot.view;
    //计算旋转的变化矩阵并赋值
    iv.transform = CGAffineTransformRotate(iv.transform, rot.rotation);
    //选择角度清零
    rot.rotation = 0;
}

-(void)pan:(UIPanGestureRecognizer*) pan{
    //获取移动的坐标 相对于视图的坐标系
    CGPoint pt = [pan translationInView:self.view];
    
    //获取移动时的相对速度
    CGPoint pv = [pan velocityInView:self.view];
    
    NSLog(@"Pan.x=%.2f,Pan.y=%.2f",pt.x,pt.y);
    NSLog(@"Pan.pv.x=%.2f,Pan.pv.y=%.2f",pv.x,pv.y);
}

-(void)swr:(UISwipeGestureRecognizer*) swg{
    NSLog(@"向左滑动");
    if (swg.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"向左滑动");
    }else if (swg.direction == UISwipeGestureRecognizerDirectionRight){
        NSLog(@"向右滑动");
    }
}

-(void)lpg:(UILongPressGestureRecognizer*)lon{
    NSLog(@"长按");
    //手势状态对象 到达规定时间 触发
    if (lon.state == UIGestureRecognizerStateBegan) {
        NSLog(@"状态开始");
        //当手指离开屏幕时 结束状态
    }else if (lon.state == UIGestureRecognizerStateEnded){
        NSLog(@"状态结束");
    }
    
    
}

//是否可以同时响应2个手势
//如果返回YES 可以 如果为NO 不行
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

//当点击屏幕开始的瞬间调用
//1 手指触碰屏幕
//2 手指接触到屏幕并且没有离开 按住屏幕时 包括按住屏幕并且移动手指
//3 手指离开屏幕瞬间
//touchesBegan 对应 1
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取点击对象 anyobject 获取任何一个点击对象
    //只有一个点击对象 获得对象就是我们的点击对象
    UITouch* t = [touches anyObject];
    NSLog(@"手指触碰瞬间");
    //tapCount 记录当前点击的 次数
    if (t.tapCount == 1) {
        NSLog(@"单次点击" );
    }else if (t.tapCount == 2){
        NSLog(@"双次点击");
    }
    
    _mplast = [t locationInView:self.view];
}

//手指在屏幕上时屌用 并且移动数据可以获取
//对应2
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"手指的移动");
    UITouch* t = [touches anyObject];
    //获得当前手指在屏幕上的相对坐标
    //相对于当前视图坐标
    CGPoint pt = [t locationInView:self.view];
    //每次 移动偏移量大小
    float x =  pt.x - _mplast.x ;
    float y = pt.y - _mplast.y;
    _mplast = pt;
    
    NSLog(@"pt.x = %f pt.y = %f",pt.x,pt.y);
    
    self.imgv.frame = CGRectMake(self.imgv.frame.origin.x + x , self.imgv.frame.origin.y + y, self.imgv.frame.size.width, self.imgv.frame.size.height);
    
}

//手指离开屏幕时屌用
//对应3
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"手指离开屏幕");
}

//在特殊情况下中断触屏事件时
//电话 紧急信息
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"特殊情况");
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

@end
