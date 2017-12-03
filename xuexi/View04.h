//
//  View04.h
//  xuexi
//
//  Created by NarutoMac on 2017/11/23.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View04 : UIViewController<UIGestureRecognizerDelegate>{
    UIImage* _img;
    UIImageView* _imgv;
    CGPoint _mplast;
    UITapGestureRecognizer * _tgr;
    UITapGestureRecognizer * _tgr2;
    //定义一个缩放手势 对视图进行放大或者缩小
    UIPinchGestureRecognizer* _pgr;
    //定义一个旋转手势 用来旋转图像视图
    UIRotationGestureRecognizer* _rgr;
    UIPanGestureRecognizer* _pan;
    UISwipeGestureRecognizer* _sgr;
    UILongPressGestureRecognizer* _lpg;
}
@property(retain,nonatomic) UIImage* img;
@property(retain,nonatomic) UIImageView* imgv;
@property(retain,nonatomic) UITapGestureRecognizer* tgr;
@property(retain,nonatomic) UITapGestureRecognizer* tgr2;
@property(retain,nonatomic) UIPinchGestureRecognizer* pgr;
@property(retain,nonatomic) UIRotationGestureRecognizer* rgr;
@property(retain,nonatomic) UIPanGestureRecognizer *pan;
@property(retain,nonatomic) UISwipeGestureRecognizer* sgr;
@property(retain,nonatomic) UILongPressGestureRecognizer* lpg;
@end
