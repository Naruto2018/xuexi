//
//  View03.m
//  xuexi
//
//  Created by NarutoMac on 2017/11/19.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "View03.h"

@interface View03 ()

@end

@implementation View03
@synthesize sv = _sv;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //定义并创建一个滚动视图
    //可以对视图内容进行滚屏
    self.sv = [[UIScrollView alloc] init];
    //设置滚动视图位置
    self.sv.frame = CGRectMake( 0, 0, 375, 812);
    //是否按照整页来滚动视图
    self.sv.pagingEnabled = YES;
    //是否可以开启滚动效果
    self.sv.scrollEnabled = YES;
    //设置画布大小，画图显示在滚动视图内部 一般大于frame大小
    self.sv.contentSize = CGSizeMake(375, 812*5);
    //是否可以边缘弹动效果
    self.sv.bounces = NO;
    //开启横向弹动效果
    self.sv.alwaysBounceHorizontal = YES;
    //开启纵向弹动效果
    self.sv.alwaysBounceVertical = YES;
    //横向滚动条
    self.sv.showsHorizontalScrollIndicator = NO;
    //纵向滚动条
    self.sv.showsHorizontalScrollIndicator = YES;
    //背景颜色
    self.sv.backgroundColor = [UIColor orangeColor];
    //是否允许通过点击屏幕让滚动视图响应事件
    //YES 滚动视图可以接收触屏事件
    //NO 不接收触屏事件
    //sv.userInteractionEnabled = NO;
    //滚动视图画布移动位置 偏移位置
    //决定画布显示的最终图像结果
    self.sv.contentOffset = CGPointMake(0, 0);
    
    //循环创建五张图片视图
    for (int i=0; i<5; i++) {
        
        NSString* pic = [NSString stringWithFormat:@"%d.JPG",i+1];
        
        UIImage* img = [UIImage imageNamed:pic];
        
        UIImageView* iv = [[UIImageView alloc] initWithImage:img];
        
        iv.frame = CGRectMake(0, 812*i, 375, 812);
        
        [self.sv addSubview:iv];
        
    }
    //将当前视图控制器作为代理对象
    self.sv.delegate = self;
    
    [self.view addSubview:self.sv];
}

//当滚动视图移动时 只要offset坐标发生变化 都会调用
//可以使用此函数监控滚动视图位置
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"y = %f",scrollView.contentOffset.y);
}

//当滚动视图结束拖动时调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"结束拖动");
}

//当滚动视图开始被拖动时调用
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"开始拖动");
}

//视图即将结束拖动时
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"即将停止拖动");
}

//视图即将减速时
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"即将减速");
}

//视图已经结束减速时 视图停止瞬间
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"视图停止移动");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    //[self.sv scrollRectToVisible:CGRectMake(0, 0, 375, 812) animated:YES];
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
