//
//  UserModel.m
//  xuexi
//
//  Created by 海顺 on 2017/11/26.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
@synthesize uid = _uid;
@synthesize username = _username;
@synthesize sex = _sex;
@synthesize images = _images;

@end

@implementation UserResAttionModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [UserModel class],};
}
@end
