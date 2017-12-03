//
//  View02.h
//  xuexi
//
//  Created by NarutoMac on 2017/11/19.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View02 : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{
    //定义开关空间
    //可以进行状态改变
    //开 关 两种状态切换
    //所有UIKIT框架库中控件都以UI开头
    UISwitch* _sw;
    //进度条对象
    //一般用来表示下载或视频播放进度
    UIProgressView* _pr;
    //滑动条
    //一般用来调整音乐的音量等
    UISlider* _sli;
    //定义步进器
    //按照一定数值来调整某个数据
    UIStepper* _ste;
    //分栏控制器
    UISegmentedControl* _seg;
    //定义一个TextField
    //文本输入 文本框
    //只能输入单行文本 不能输入或显示多行
    UITextField* _tf;
    //定义一个警告对话框
    UIAlertView* _av;
    UIAlertController* _avs;
    //等待提示对象
    //下载或者加载比较大的文件时 可以显示
    UIActivityIndicatorView* _aiv;
    
    
}

@property (retain,nonatomic) UISwitch* sw;
@property (retain,nonatomic) UIProgressView*  pr;
@property (retain,nonatomic) UISlider* sli;
@property (retain,nonatomic) UIStepper* ste;
@property (retain,nonatomic) UISegmentedControl* seg;
@property (retain,nonatomic) UITextField* tf;
@property (retain,nonatomic) UIAlertView* av;
@property (retain,nonatomic) UIAlertController* avs;
@property (retain,nonatomic) UIActivityIndicatorView* aiv;

@end
