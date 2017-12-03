//
//  PicViewCell.m
//  xuexi
//
//  Created by 鸣人 on 2017/12/2.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "PicViewCell.h"
#import <SDCycleScrollView.h>
@interface PicViewCell()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@end

@implementation PicViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _cycleScrollView  =[SDCycleScrollView cycleScrollViewWithFrame:CGRectZero  imageURLStringsGroup:@[@"https://app.bocim.com/frontapi/images/index?path=/images/pic/pichuoqibao201704131600211906543123.jpg",@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"]];
        [self addSubview:_cycleScrollView];

        _cycleScrollView.delegate = self;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
