//
//  ViewController.h
//  xuexi
//
//  Created by NarutoMac on 2017/11/14.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController{
    MPMoviePlayerController*  _playerController;
    UIButton* _t;
    UIButton* _t2;
    UIButton* _t3;
    //定义一个定时器对象
    //可以每隔固定时间发送一个消息
    //通过此消息来调用x相应的时间函数
    //通过此函数可以在固定时间段来完成一个根据时间间隔任务
    NSTimer* _Timeview;
}

//定时器的属性对象
@property (retain,nonatomic) NSTimer* Timeview;
@property (retain,nonatomic) UIButton* t;
@property (retain,nonatomic) UIButton* t2;
@property (retain,nonatomic) UIButton* t3;

@end

