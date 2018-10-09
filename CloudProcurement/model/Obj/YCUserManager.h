//
//  YCUserManager.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCUserInfo.h"
#import "YCTypeDefObj.h"
NS_ASSUME_NONNULL_BEGIN
/**
 用户管理类
 */
@interface YCUserManager : NSObject
+ (instancetype)shareIns;
#pragma mark login method

/**
 当前用户是否登录

 @return yes or no
 */
- (BOOL)isLogined;

/**
 登录函数

 @param userName 登录名
 @param password 登录密码
 @param sucBlock 登录成功回调
 @param failedBlock 登录失败回调
 */
- (void)login:(NSString *)userName password:(NSString *)password sucBlock:(ONE_PARAM_BLOCK)sucBlock failedBlock:(ONE_PARAM_BLOCK)failedBlock;

/**
 用户下线函数

 @param userName 用户名
 @param sucBlock 成功回调
 @param failedBlock 失败回调
 */
- (void)logout:(NSString *)userName sucBlock:(ONE_PARAM_BLOCK)sucBlock failedBlock:(ONE_PARAM_BLOCK)failedBlock;
#pragma mark userInfo method
@property (nonatomic, strong, readonly) YCUserInfo *curUserInfo;

/**
 更新用户信息

 @param userInfo 新的用户信息
 */
- (void)updateUserInfo:(YCUserInfo *)userInfo;

/**
 保存登录信息

 @param userName 用户名
 @param password 用户密码1
 @return 保存成功yes 失败NO
 */
- (BOOL)saveLoginInfo:(NSString *)userName password:(NSString *)password;

/**
 保存当前登录的用户信息
 */
- (void)saveUserInfo;
/**
 获取前一次登录的用户信息
 
 @return 用户信息
 */
- (YCUserInfo *)beforeUserInfo;

- (NSDictionary<NSString *, id> *)getOneLoginInfo;
- (NSArray<NSDictionary<NSString *, id> *> *)getAllLoginInfo;
@end

NS_ASSUME_NONNULL_END
