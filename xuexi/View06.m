//
//  View06.m
//  xuexi
//
//  Created by 鸣人 on 2017/11/25.
//  Copyright © 2017年 鸣人. All rights reserved.
//

#import "View06.h"
#import "AFNetworking.h"
#import "ViewController.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"
#import <SDCycleScrollView.h>
#import <MJRefresh.h>

NSString *const cellstr = @"Cell";

@interface View06 ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@end

@implementation View06
@synthesize t = _t;
@synthesize result = _result;
@synthesize datajson = _datajson;
@synthesize tv = _tv;
@synthesize results = _results;
@synthesize Data = _Data;
@synthesize bedit = _bedit;
@synthesize bfinish = _bfinish;
@synthesize bdel = _bdel;
@synthesize isEdit = _isEdit;
@synthesize bback = _bback;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.toolbarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
     _Data = [[NSMutableArray alloc] init];
    
    _cycleScrollView  =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200)  imageURLStringsGroup:@[@"https://app.bocim.com/frontapi/images/index?path=/images/pic/pichuoqibao201704131600211906543123.jpg",@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"]];
    [self.view addSubview:_cycleScrollView];

    _cycleScrollView.delegate = self;
    
//    _t = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [_t setTitle:@"下载数据" forState:UIControlStateNormal];
//    [_t setBackgroundColor:[UIColor whiteColor]];
//    _t.frame = CGRectMake(50, 50, 100, 40);
//    [_t addTarget:self action:@selector(connurl) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view addSubview:_t];
    
    //创建一个数据视图
    //1 视图位置
    //2 数据视图的风格 1 UITableViewStylePlain 普通风格 UITableViewStyleGrouped 分组风格
    _tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, ScreenHeight)style:UITableViewStylePlain];
    
    //自动调整子视图的大小
    _tv.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //设置数据视图代理对象
    _tv.delegate = self;
    //设置数据视图的数据源对象
    _tv.dataSource = self;
    
    //数据视图的头部视图设定
    _tv.tableHeaderView = nil;
    //数据视图的尾部视图设定
    _tv.tableFooterView = nil;
    
    _tv.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tv.separatorColor = [UIColor blackColor];
    
  
    
    self.title = @"页面6";
     [_tv registerClass:[UITableViewCell class] forCellReuseIdentifier:cellstr];
    
  
    [self.view addSubview:_tv];
    
    [self AFNetMonitor];
    [self AFGetData];
    [self Cbtn];
    
    [self startRefresh];
}

-(void)refresh{
    NSLog(@"111");
}

-(void)setRefreshBlock:(GloableBlock)refreshBlock{
    _refreshBlock =refreshBlock;
    NSLog(@"setRefreshBlock");
    _tv.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //_size =20;
        _page =0;
        NSLog(@"setRefreshBlock");
        if (_refreshBlock) {
            _refreshBlock(_tv.mj_header);
        }
    }];
}
-(void)setLoadMoreBlock:(GloableBlock)loadMoreBlock{
    _loadMoreBlock =loadMoreBlock;
    _tv.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_loadMoreBlock) {
            _loadMoreBlock(_tv.mj_footer);
        }
    }];
}
-(void)startRefresh{
    [_tv.mj_header beginRefreshing];
}
-(void)stopRefresh{
    if ([_tv.mj_header isRefreshing]) {
        [_tv.mj_header endRefreshing];
    }
    if ([_tv.mj_footer isRefreshing]) {
        [_tv.mj_footer endRefreshing];
    }
}

-(void) Cbtn{
    _isEdit = NO;
    
    _bedit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    
    _bedit.tintColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = _bedit;
    
    _bdel = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(del)];
    
    _bback = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backto)];
    
    _bback.tintColor = [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem = _bback;
    
    _bdel.tintColor = [UIColor blackColor];
    
    _bfinish = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    
    _bfinish.tintColor = [UIColor blackColor];
}

-(void) edit{
    _isEdit = YES;
    self.navigationItem.rightBarButtonItem = _bfinish;
    [_tv setEditing:YES];
    self.navigationItem.leftBarButtonItem = _bdel;
    
}

-(void) finish{
    _isEdit = NO;
    self.navigationItem.rightBarButtonItem = _bedit;
    [_tv setEditing:NO];
    self.navigationItem.leftBarButtonItem = _bback;
}

-(void) del{
    NSLog(@"del");
}

-(void) backto{
//返回第一层
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//每组元素的个数(行数）
//必须要实现的函数
//程序在显示视图时 会调用
//返回 每组元素个数
//1 数据视图对象本身
//2 哪一组需要的行数
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",[_Data count]);
    return [_Data count]-1;
}

//设置数据视图组数
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//创建单元格对象函数
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //尝试获取可复用的单元格
    //如果获取不到 返回为空 nil
//     _cell = [_tv dequeueReusableCellWithIdentifier:cellstr];
//
//    if (_cell == nil) {
//        //创建一个单元格对象
//        //1 单元格样式
//        //2 单元格复用标记
//        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
//        _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellstr];
//    }
    
    _cell = [_tv dequeueReusableCellWithIdentifier:cellstr forIndexPath:indexPath];

    
    //NSString *name = [[_Data objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    //将单元格的主文字内容 赋值
    //获取对应数据
    UserModel* User = [_Data objectAtIndex:indexPath.row];
    
    NSString* zwstr = [NSString stringWithFormat:@"名字 %@",User.username];
    NSString* fbtstr = [NSString stringWithFormat:@"用户ID %@",User.uid];
    
    if (![User.images containsString:@"http://wz.mkangou.com/"]) {
        User.images  = [NSString stringWithFormat:@"http://wz.mkangou.com/%@",User.images];
    }
    
    
    //  NSURL* imgurl = [NSURL URLWithString:imgstr];
    //UIImage* img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgurl]];
    //cell.imageView.image = img;

    //cell.imageView.frame = CGRectMake(150, 15, 150, 70);
    
    _imageView = [[UIImageView alloc] init];
    [_imageView setFrame:CGRectMake(150, 5, 90, 90)];
//    //imageView.frame = cell.textLabel.bounds;
    [_cell.contentView addSubview:_imageView];
    
    //UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:[NSString stringWithFormat:@"%@",imgstr]];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:User.images ];
    if (image) {
        _imageView.image = image;
    } else {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:User.images ] placeholderImage:[UIImage imageNamed:@"IMG_1413.JPG"]];
    }
    //清除缓存
    //[[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    
    
    
    _cell.textLabel.text = zwstr;
    _cell.detailTextLabel.text =  fbtstr;
    
    
    return _cell;
}

//获取高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

//获取每组头部标题
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"我来组成头部!";
//}

//获取每组尾部标题
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"我来组成腿部";
}

//获取头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

//获取尾部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}

//单元格显示效果协议 默认删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //默认删除 UITableViewCellEditingStyleDelete
    //UITableViewCellEditingStyleInsert 插入
    //UITableViewCellEditingStyleNone 虚无
    //UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert 多选状态
    return UITableViewCellEditingStyleDelete;
}

//可以显示编辑状态 当手指在单元格上移动时
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"del");
    
    [_Data removeObjectAtIndex:indexPath.row];
    //[_Data removeObjectsInArray:_Data[indexPath.row][@"name"]];
    [_tv reloadData];
}

//选中单元格调用协议函数
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中单元格->%ld",indexPath.row);
    NSMutableArray *browser_items = @[].mutableCopy;
    //获取对应数据
    UserModel* User = [_Data objectAtIndex:indexPath.row];
    
    if (![User.images containsString:@"http://wz.mkangou.com/"]) {
        User.images  = [NSString stringWithFormat:@"http://wz.mkangou.com/%@",User.images];
    }
    
    KSPhotoItem *item = [KSPhotoItem itemWithSourceView:_imageView imageUrl:[NSURL URLWithString:User.images ]];
    [browser_items addObject:item];
    
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:browser_items selectedIndex:0];
    browser.delegate = self;
    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleSlide;
    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlack;
    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
    browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleDot;
    browser.bounces = NO;
    [browser showFromViewController:self];
    
}

//取消选中时调用协议函数
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选中单元格->%ld",indexPath.row);
}



- (void)connurl{
    
    [self AFNetMonitor];
    [self AFGetData];
}

-(void)AFGetData{
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    //创建HTTP链接管理对象
    AFHTTPSessionManager* s = [AFHTTPSessionManager manager];
    //NSDictionary *params1 = @{@"s":@(self.attionView.page *5),@"p":@"5",@"cid":@"5"};
    @weakify(self);
     self.refreshBlock = ^(View06 * refreshView) {
         @strongify(self);
         NSLog(@"refreshBlock");
         NSDictionary *dict = @{ @"s":@"0",@"p":@"5" };
         s.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
         //通过GET方法
         //1 参数传入一个URL对象
         //2 通过指定的结果传入参数
         //3 指定下载进度UI
         //4 下载成功后数据调用 1 下载的任务线程 2 返回的数据内容
         //5 下载失败后调用 1 下载的任务线程 2 返回的错误类型
         [s GET:@"http://wz.mkangou.com/index.php?Action=applexuexi" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"下载成功");
             
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 NSLog(@"res = %@",responseObject);
                 [self stopRefresh];
                 [SVProgressHUD dismiss];
                 //_results = (NSDictionary *)responseObject;
//                 _results = [[NSMutableDictionary alloc] initWithDictionary: responseObject];
//                 NSLog(@"name = %@",_results[@"msg"]);
//
//                 [self parsaData:responseObject];
                 
                 UserResAttionModel *resModel = [UserResAttionModel yy_modelWithJSON:responseObject];
                 //self.dataSource = [resModel.content copy];
                 _Data = [resModel.data copy];
                 [_tv reloadData];
                 _page ++;
                 
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"下载失败->%@", error);
         }];
     };
    [self startRefresh];
    self.loadMoreBlock = ^(View06 * refreshView) {
        NSLog(@"loadMoreBlock");
        @strongify(self);
        NSDictionary *dict = @{ @"s":@(_page *5),@"p":@"5" };

        s.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //通过GET方法
        //1 参数传入一个URL对象
        //2 通过指定的结果传入参数
        //3 指定下载进度UI
        //4 下载成功后数据调用 1 下载的任务线程 2 返回的数据内容
        //5 下载失败后调用 1 下载的任务线程 2 返回的错误类型
        [s GET:@"http://wz.mkangou.com/index.php?Action=applexuexi" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"下载成功");
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSLog(@"res = %@",responseObject);
                [self stopRefresh];
                [SVProgressHUD dismiss];
                //_results = (NSDictionary *)responseObject;
                _results = [[NSMutableDictionary alloc] initWithDictionary: responseObject];
                NSLog(@"name = %@",_results[@"msg"]);
                
                UserResAttionModel *resModel = [UserResAttionModel yy_modelWithJSON:responseObject];
                //_count = [_results[@"count"] integerValue ];
                if (_page*5 > resModel.count) {
                   CGToast(@"没有更多了");
                }else{
                    NSMutableArray *temp =[NSMutableArray arrayWithArray:_Data];
                    //RES 添加到TEMP
                    [temp addObjectsFromArray:resModel.data];
                    resModel.data = temp;
                    _Data = [resModel.data copy];
                    [_tv reloadData];
                    _page ++;
                    
//                    NSMutableArray* arryEnter = [responseObject objectForKey:@"data"];
//                    NSMutableArray *temp =[NSMutableArray arrayWithArray:_Data];
//
//                    //RES 添加到TEMP
//                    //[temp addObjectsFromArray:resModel.content];
//                    for (int i = 0; i<arryEnter.count; i++) {
//                        NSDictionary* dicUser = [arryEnter objectAtIndex:i];
//                        NSString* uid = [dicUser objectForKey:@"id"];
//                        NSString* username = [dicUser objectForKey:@"user"];
//                        NSString* sex = [dicUser objectForKey:@"sex"];
//                        NSString* images = [dicUser objectForKey:@"images"];
//
//                        UserModel* User = [[UserModel alloc] init];
//
//                        User.uid = uid;
//                        User.username = username;
//                        User.sex = sex;
//                        User.images = images;
//
//                        [_Data addObject:User];
//                    }
//
//
//                    [_tv reloadData];
//                    _page++;
                }
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"下载失败->%@", error);
        }];
    };
    
}

-(void)setResModel:(UserResAttionModel *)resModel{
    _Data = [resModel.data copy];
}

-(void)AFNetMonitor{
    //检测网络链接状态
    //AFNetworkReachabilityManager 网络监测管理类
    //开启网络状态监控器
    //sharedManager 获取唯一单例对象
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //获取网络链接结果
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络链接");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi网络链接");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"移动网络,4G");
                break;
            default:
                break;
        }
    }];
}

-(void) parsaData:(NSMutableDictionary*) dicData{
   
    //_Data = [[NSMutableArray alloc] initWithArray:_results[@"data"]];
    
    NSMutableArray* arryEnter = [dicData objectForKey:@"data"];
    
    for (int i = 0; i<arryEnter.count; i++) {
        NSDictionary* dicUser = [arryEnter objectAtIndex:i];
        
        
        NSString* userid = [dicUser objectForKey:@"id"];
        NSString* username = [dicUser objectForKey:@"user"];
        NSString* sex = [dicUser objectForKey:@"sex"];
        NSString* images = [dicUser objectForKey:@"images"];
        
        UserModel* User = [[UserModel alloc] init];
        
        User.uid = userid;
        User.username = username;
        User.sex = sex;
        User.images = images;
        
        [_Data addObject:User];
        
    }
    
    //当数据视图的数据源发生变化时
    //更新数据视图 重新加载数据
    [_tv reloadData];
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
