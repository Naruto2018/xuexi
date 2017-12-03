//
//  AppDelegate.m
//  xuexi
//
//  Created by NarutoMac on 2017/11/14.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "View06.h"
#import "View02.h"
#import "View03.h"
#import "View04.h"
#import "View05.h"

@interface AppDelegate ()
//@property(nonatomic ,strong) UIBackgroundTaskIdentifier _bgTaskId;
@end

@implementation AppDelegate

//框架初始化成功后调用 初始化整个程序框架结构
//入口函数
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [NSThread sleepForTimeInterval:3.0]; //设置启动页面时间,系统默认1秒
    //创建一个UIWINDOWS 对象
    //在程序上表示屏幕窗口
    //UIScreen 屏幕硬件类
    //mainScreen 获取主屏幕信息
    //bounds 当前屏幕的宽高值
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //创建分栏控制器
    UITabBarController* tab = [[UITabBarController alloc] init];
    
    //创建视图控制对象
    ViewController* vcRoot = [[ViewController alloc] init];
    //vcRoot.title = @"首页";
    
    
    View02* vc2 = [[View02 alloc] init];
    //vc2.title = @"页面2";
    
    UIImage* img2 = [[UIImage imageNamed:@"f2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem* item2 = [[UITabBarItem alloc] initWithTitle:nil image:img2 tag:302];
    
    item2.imageInsets = UIEdgeInsetsMake(5,0, -5,0);
    
    vc2.tabBarItem = item2;
    
    View03* vc3 = [[View03 alloc] init];
    //vc3.title = @"页面3";
    
    UIImage* img3 = [[UIImage imageNamed:@"f3.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem* item3 = [[UITabBarItem alloc] initWithTitle:nil image:img3 tag:303];
    
    item3.imageInsets = UIEdgeInsetsMake(5,0, -5,0);
    
    vc3.tabBarItem = item3;
    View04* vc4 = [[View04 alloc] init];
    vc4.title = @"页面4";
    
    UIImage* img4 = [[UIImage imageNamed:@"f4.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem* item4 = [[UITabBarItem alloc] initWithTitle:nil image:img4 tag:304];
    
    item4.imageInsets = UIEdgeInsetsMake(5,0, -5,0);
    
    vc4.tabBarItem = item4;
    View05* vc5 = [[View05 alloc] init];
    vc5.title = @"页面5";
    
    UIImage* img5 = [[UIImage imageNamed:@"f4.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem* item5 = [[UITabBarItem alloc] initWithTitle:@"111" image:img5 tag:305];
    
    item5.imageInsets = UIEdgeInsetsMake(0, 0, 20, 20);
    
    

    vc5.tabBarItem=item5;
    
    View06* vc6 = [[View06 alloc] init];
    vc6.title = @"页面6";
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vcRoot];
    
    UIImage* img1 = [[UIImage imageNamed:@"f1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem* item1 = [[UITabBarItem alloc] initWithTitle:nil image:img1 tag:301];
    
    //按钮右上角提示信息
    item1.badgeValue = @"200";
    //提示信息颜色
    item1.badgeColor = [UIColor redColor];
    
    item1.imageInsets = UIEdgeInsetsMake(5,0, -5,0);
    
    nav.tabBarItem = item1;
    
    
    
    //创建控制器数组
    //将所有要被分栏控制器管理的对象添加到数组中
    NSArray* arry = [NSArray arrayWithObjects:nav, vc2,vc3,vc4,vc5,vc6,nil];
    
    //将分栏视图控制器管理数组进行赋值
    tab.viewControllers =  arry;
    
    //设置选中视图控制器的索引
    //通过索引来确定显示哪一个控制器
    tab.selectedIndex = 0;
    
    //当前选中的控制器对象
    if (tab.selectedViewController == nav) {
        NSLog(@"选中0");
    }
    
    //设置分栏控制器的工具栏的透明度
    tab.tabBar.translucent = NO;
    
    
    
    //创建视图控制器 作为UI WINDOWS的根视图控制器
    //self.window.rootViewController = [[UIViewController alloc] init];
    //对窗口的根视图控制器进行赋值操作
    //视图控制器 用来管理界面和处理界面的逻辑对象
    self.window.rootViewController = tab;
    

    
    self.window.backgroundColor = [UIColor blackColor];
    //将WINDOW作为主视图并显示
    [self.window makeKeyAndVisible];
    
//    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//
//    [v setBackgroundColor:[UIColor orangeColor]];
//
//    //背景视图
//    UIView* b = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
//
//    [b setBackgroundColor:[UIColor whiteColor]];
//
//    //将B 作为V 的父亲视图
//    //子视图坐标参照父亲视图
//    //当父亲视图移动时 所有子视图都会跟随移动
//    [b addSubview:v];
//
//    [self.window addSubview:b];
//
//    NSLog(@"%@",v.window);
//    NSLog(@"%@",b.window);
//    NSLog(@"%@",self.window);
    
    [self _enteranceControl:launchOptions];
    return YES;
}

-(void)_enteranceControl:(NSDictionary *)launchOptions{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
