//
//  View05.m
//  xuexi
//
//  Created by NarutoMac on 2017/11/24.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "View05.h"

@interface View05 ()

@end

@implementation View05
@synthesize conn = _conn;
@synthesize data = _data;
@synthesize t = _t;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _t = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_t setTitle:@"下载数据" forState:UIControlStateNormal];
    [_t setBackgroundColor:[UIColor whiteColor]];
    _t.frame = CGRectMake(100, 100, 100, 40);
    [_t addTarget:self action:@selector(connurl) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_t];
}

- (void)connurl{
    //定义网址
    NSString* strurl = @"http://wz.mkangou.com/index.php?Action=getuserimg&appuid=33";
    
    //将字符串转成地址链接对象
    NSURL* url = [NSURL URLWithString:strurl];
    
    //定义一个链接请求对象
    NSURLRequest*  reu = [NSURLRequest requestWithURL:url];
    
    //创建一个网络链接对象
    //1 链接的请求对象
    //2 代理对象 用来实现回传数据的代理协议
    _conn = [NSURLConnection connectionWithRequest:reu delegate:self];
    
    _data = [[NSMutableData alloc] init];
}

//处理错误信息代理
//如果有任何链接错误 会调用此协议 进行错误打印
//1 链接对象
//2 错误信息
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error %@",error);
}

//处理服务器返回的响应吗
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //将 响应码转为HTTP响应吗
    NSHTTPURLResponse* res = (NSHTTPURLResponse*) response;
    
    if (res.statusCode == 200) {
        NSLog(@"服务器正常");
    }else if (res.statusCode == 404){
        NSLog(@"页面链接不存在");
    }else if (res.statusCode == 500){
        NSLog(@"服务器宕机或关机 或者程序报错");
    }
}

//接收服务器回传数据时调用
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //将每次回传的数据链接起来
    [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //将二进制数据转化为字符串数据
    NSString* str = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    
    NSLog(@"1%@",str);
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
