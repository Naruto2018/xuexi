//
//  View06.h
//  xuexi
//
//  Created by NarutoMac on 2017/11/25.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSPhotoBrowser.h"
typedef void (^GloableBlock)(id x);

//数据视图协议 数据视图普通事件处理  数据视图的数据代理协议->处理数据视图数据代理
@interface View06 : UIViewController<UITableViewDelegate,UITableViewDataSource,KSPhotoBrowserDelegate>{
    UIButton* _t;
    NSString* _result;
    NSData* _datajson;
    NSMutableDictionary* _results;
    NSMutableArray* _Data;
    
    //定义一个数据视图对象
    UITableView* _tv;
    UIImageView* _imageView;
    UITableViewCell* _cell;
    
    
    UIBarButtonItem* _bedit;
    UIBarButtonItem* _bfinish;
    UIBarButtonItem* _bdel;
    UIBarButtonItem* _bback;
    BOOL _isEdit;
    
}
@property(retain,nonatomic) UIButton* t;
@property(retain,nonatomic) NSString* result;
@property(retain,nonatomic) NSData* datajson;
@property(retain,nonatomic) UITableView* tv;
@property(retain,nonatomic) NSMutableDictionary* results;
@property(retain,nonatomic) NSMutableArray* Data;
@property(retain,nonatomic) UIBarButtonItem* bedit;
@property(retain,nonatomic) UIBarButtonItem* bfinish;
@property(retain,nonatomic) UIBarButtonItem* bdel;
@property(retain,nonatomic) UIBarButtonItem* bback;
@property(assign,nonatomic) BOOL isEdit; //正确写法
@property(nonatomic,copy)GloableBlock refreshBlock;
@property(nonatomic,copy)GloableBlock loadMoreBlock;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger size;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) int k;

@end
