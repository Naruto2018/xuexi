//
//  View02.m
//  xuexi
//
//  Created by NarutoMac on 2017/11/19.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "View02.h"

@interface View02 ()

@end

@implementation View02

//同步属性和成员变量
@synthesize sw = _sw;
@synthesize pr = _pr;
@synthesize sli = _sli;
@synthesize ste = _ste;
@synthesize seg = _seg;
@synthesize tf = _tf;
@synthesize av = _av;
@synthesize avs = _avs;
@synthesize aiv = _aiv;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //关键开关对象
    _sw = [[UISwitch alloc] init];
    //进度条创建
    _pr = [[UIProgressView alloc] init];
    //创建滑动条
    _sli = [[UISlider alloc] init];
    //创建步进器对象
    _ste = [[UIStepper alloc] init];
    //创建分栏控制器对象
    _seg = [[UISegmentedControl alloc] init];
    //创建一个文本输入区对象
    self.tf = [[UITextField alloc] init];
    
    
    //苹果官方的控件位置设置
    //位置X,Y 可以改变 宽 高 无法改变
    _sw.frame = CGRectMake(50, 50, 100, 100);
    //进度条位置 X,Y 宽 可以变 高无法改变
    _pr.frame = CGRectMake(100, 100, 200, 50);
    //滑动位置 X,Y 宽 可以变 高无法改变
    _sli.frame = CGRectMake(100, 150, 200, 50);
    //位置 X,Y  可以变 宽 高无法改变
    _ste.frame = CGRectMake(100, 200, 200, 50);
    //位置 X,Y 宽 可以变 高无法改变
    _seg.frame = CGRectMake(100, 250, 200, 50);
    //设定文本输入区文字
    self.tf.frame = CGRectMake(100, 310, 200, 50);
    
    for(int i = 0;i<2;i++){
        UIButton* btnn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnn.frame = CGRectMake(100, 400+50*i,  100, 40);
        
        if (i == 0) {
            [btnn setTitle:@"警告对话框" forState:UIControlStateNormal];
        }
        
        if (i == 1) {
            [btnn setTitle:@"等待对话框" forState:UIControlStateNormal];
        }
        
        btnn.tag =  110 + i;
        [btnn addTarget:self action:@selector(duihuakuang:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnn];
    }
    
    //设置内容文字
    self.tf.text = @"用户名";
    //设置字体大小
    self.tf.font = [UIFont systemFontOfSize:20];
    //设置字体颜色
    self.tf.textColor = [UIColor orangeColor];
    //设置边框的风格
    //UITextBorderStyleRoundedRect 圆角
    //UITextBorderStyleLine 线框
    //UITextBorderStyleBezel Bezel线框
    //UITextBorderStyleNone 无边框风格
    self.tf.borderStyle = UITextBorderStyleRoundedRect;
    
    //设置虚拟键盘风格
    //UIKeyboardTypeDefault 默认风格
    //UIKeyboardTypeNamePhonePad 字母和数子组合风格
    //UIKeyboardTypeNumberPad 纯数子风格
    self.tf.keyboardType = UIKeyboardTypeNumberPad;
    //设置提示文字属性
    //当TEXT为空时显示
    self.tf.placeholder = @"请输入用户名……";
    //是否密码输入
    //YES 做为密码 NO 普通文字
    self.tf.secureTextEntry = YES;
    
    
    
    
    //添加一个按钮元素
    //1 按钮选项
    //2 按钮索引位置
    //3 是否有插入的动画效果
    [_seg insertSegmentWithTitle:@"0元" atIndex:0 animated:NO];
    [_seg insertSegmentWithTitle:@"5元" atIndex:1 animated:NO];
    [_seg insertSegmentWithTitle:@"10元" atIndex:2 animated:NO];
    
    //当前默认按钮索引设置
    _seg.selectedSegmentIndex = 0;
    
    //设置开启状态风格颜色
    [_sw setOnTintColor:[UIColor blueColor]];
    
    //设置整体状态风格颜色
    [_sw setTintColor:[UIColor redColor]];
    
    //设置开关按钮风格颜色
    [_sw setThumbTintColor:[UIColor orangeColor]];
    
    //设置进度条风格颜色值
    [_pr setProgressTintColor:[UIColor orangeColor]];
    
    [_pr setTrackTintColor:[UIColor greenColor]];
    
    //设置进度条 进度值 0 ~ 1 最小0 最大1
    //0.5=>50%
    _pr.progress = 0;
    
    //设置进度条风格
    [_pr setProgressViewStyle:UIProgressViewStyleDefault];
    
    //设置滑动条最大值
    [_sli setMaximumValue:100];
    //设置步进器最大值
    _ste.maximumValue = 100;
    
    //设置滑动条最小值 可以为负值
    [_sli setMinimumValue:0];
    //设置步进器最小值
    _ste.minimumValue = 0;
    
    //设置滑块条滑块的位置 float值
    [_sli setValue:0];
    //_sli.value = 50;
    
    //设置步进器当前值
    _ste.value = 10;
    
     //设置步进值 每次向前或向后步进
    _ste.stepValue = 5;
    
    //是否可以重复响应事件
    _ste.autorepeat = YES;
    
    //是否将步进结果通过事件函数响应出来
    _ste.continuous = YES;
    
    
    
    //设置左侧滑条背景颜色
    [_sli setMinimumTrackTintColor:[UIColor orangeColor]];
    
    //设置右侧滑条背景颜色
    _sli.maximumTrackTintColor = [UIColor blueColor];
    
    //设置滑块的颜色
    _sli.thumbTintColor = [UIColor yellowColor];
    
    //对滑动条添加事件函数
    [_sli addTarget:self action:@selector(huaodng) forControlEvents:UIControlEventValueChanged];
    
    
    //向开关添加事件函数
    //1 函数实现对象
    //2 实现函数
    //3 事件响应的事件类型 UIControlEventValueChanged 状态发生变化时触发
    [_sw addTarget:self action:@selector(kaiguan:) forControlEvents:UIControlEventValueChanged];
    
    //添加步进事件函数
    [_ste addTarget:self action:@selector(bujin) forControlEvents:UIControlEventValueChanged];
    
    //添加分栏按钮事件函数
    [_seg addTarget:self action:@selector(fenlan) forControlEvents:UIControlEventValueChanged];
    
    
    //开关状态设置
    //YES 开 NO 关
    //_sw.on = YES;
    //[_sw setOn:YES];
    
    //开关函数
    //1 状态设置
    //2 是否开启动画效果
    [_sw setOn:NO animated:YES];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_sw];
    [self.view addSubview:_pr];
    [self.view addSubview:_sli];
    [self.view addSubview:_ste];
    [self.view addSubview:_seg];
    [self.view addSubview:self.tf];
    
    //设置代理对象
    self.tf.delegate = self;
    
    
}


//参数开关对象本身
- (void)kaiguan:(UISwitch*) sw{
    if (sw.on == YES) {
        NSLog(@"开");
    }else{
        NSLog(@"关");
    }
    NSLog(@"开关发生变化!");
}

- (void)huaodng{
    _pr.progress =(_sli.value - _sli.minimumValue) / (_sli.maximumValue - _sli.minimumValue);
    NSLog(@"滑动发生变化!=> %f",_sli.value);
}

- (void)bujin{
    NSLog(@"步进!=>%f",_ste.value);
}

- (void)fenlan{
    NSLog(@"选择分栏=>%d",_seg.selectedSegmentIndex);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //使虚拟键盘回收
    [self.tf resignFirstResponder];
    //使当前视图控制器消失
    //1 是否动画效果
    //2 结束后是否调用功能
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"开始编辑");
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"编辑结束");
}

//是否可以进行输入
//如果返回YES 可以进行输入 默认YES
//NO 不能输入文字
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

//是否可以结束输入
//如果返回YES 可以结束输入 默认YES
//NO 不能结束输入
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (void) duihuakuang:(UIButton*) btnn{
    //警告
    if (btnn.tag == 110) {
        NSLog(@"警告");
        //警告对话框创建
        //1 对话框标题
        //2 提示内容
        //3 处理按钮事件代理对象
        //4 取消按钮文字
        //5 其他按钮文字
        //6 添加其他按钮
         _av = [[UIAlertView alloc] initWithTitle:@"警告" message:@"警告内容"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //_avs = [UIAlertController alertControllerWithTitle:@"警告" message:@"警告内容" preferredStyle:  UIAlertControllerStyleAlert];
        
        //[_avs addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
        //}]];
        
        //[_avs addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        //[_avs addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        
        //弹出提示框；
        //[self presentViewController:_avs animated:true completion:nil];
        
        //显示警告对话框
        [_av show];
    }else if (btnn.tag == 111) {
        NSLog(@"等待");
        //宽高 不可变更
        _aiv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100, 500, 30, 30)];
        //设定提示风格 小灰 小白 大白
        _aiv.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        //启动 动画显示
        [_aiv startAnimating];
        //停止 动画显示
        //[_aiv stopAnimating];
        
        [self.view setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:_aiv];
        
    }
}

//当点击对话框按钮时调用此函数
//1 对话框对象本身
//2 按钮索引
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"index = %d\n",buttonIndex);
}

//对话框消失的时候调用此韩束
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"即将消失!");
}

//对话框已经消失
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"已经消失!");
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
