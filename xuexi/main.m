//
//  main.m
//  xuexi
//
//  Created by NarutoMac on 2017/11/14.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//整个APP的入口函数
int main(int argc, char * argv[]) {
    //自动内存释放池
    @autoreleasepool {
        //UIKIT 框架结构的启动函数
        //argc 启动时 参数个数
        //argv 参数列表
        //参数三 要求传入一个主框架类 nil 系统会使用默认框架类
        //参数四 主框架代理类
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
