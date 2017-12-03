//
//  View05.h
//  xuexi
//
//  Created by NarutoMac on 2017/11/24.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import <UIKit/UIKit.h>
//1 链接服务器对象的数据代理 回传数据使用 2 链接服务的普通代理协议 作为错误处理等普通协议
@interface View05 : UIViewController<NSURLConnectionDataDelegate,NSURLConnectionDelegate>{
    //定义1个URL链接对象 通过网络地址
    //按照HTTP协议来进行传输数据工作
    NSURLConnection* _conn;
    //创建一个可变的二进制数据对象 接收服务器传回数据
    NSMutableData* _data;
    
    UIButton* _t;
}

@property(retain,nonatomic) NSURLConnection* conn;
@property(retain,nonatomic) NSMutableData* data;
@property(retain,nonatomic) UIButton* t;
@end
