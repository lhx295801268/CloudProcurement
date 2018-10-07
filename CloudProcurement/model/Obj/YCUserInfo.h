//
//  YCUserInfo.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用户信息类
 */
@interface YCUserInfo : NSObject
//用户昵称
@property (nonatomic, copy) NSString *nickName;
//用户头像地址
@property (nonatomic, copy) NSString *avartStr;
//用户电话
@property (nonatomic, copy) NSString *phoneNumber;



//用户登录成功之后的token
@property (nonatomic, copy) NSString *userToken;

- (void)updateInfo:(YCUserInfo *)info;
@end

NS_ASSUME_NONNULL_END
