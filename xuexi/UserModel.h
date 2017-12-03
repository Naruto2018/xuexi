//
//  UserModel.h
//  xuexi
//
//  Created by 海顺 on 2017/11/26.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject{
    NSString* _uid;
    NSString* _username;
    NSString* _sex;
    NSString* _images;
}
@property (nonatomic,copy) NSString* uid;
@property (nonatomic,copy) NSString* username;
@property (nonatomic,copy) NSString* sex;
@property (nonatomic,copy) NSString* images;
@end

@interface UserResAttionModel : NSObject
@property (nonatomic,copy) NSArray *data;
@property (nonatomic,assign) NSInteger count;

@end
