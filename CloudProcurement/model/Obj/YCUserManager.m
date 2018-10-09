//
//  YCUserManager.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCUserManager.h"
#import <UIKit/UIKit.h>
#import "YYModel.h"
#import "SSKeychain.h"
#import "YCPathConfig.h"
#import "YCFileManager.h"
@interface YCUserManager()
@property (nonatomic, assign) BOOL userIsLogined;
@end
@implementation YCUserManager
+ (instancetype)shareIns{
    static YCUserManager *shareIns;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareIns = [[YCUserManager alloc] init];
    });
    return shareIns;
}
#pragma mark login method

/**
 当前用户是否登录
 
 @return yes or no
 */
- (BOOL)isLogined{
    return self.userIsLogined;
}

/**
 登录函数
 
 @param userName 登录名
 @param password 登录密码
 @param sucBlock 登录成功回调
 @param failedBlock 登录失败回调
 */
- (void)login:(NSString *)userName password:(NSString *)password sucBlock:(ONE_PARAM_BLOCK)sucBlock failedBlock:(ONE_PARAM_BLOCK)failedBlock{
//    || [userName isEqualToString:self.curUserInfo.phoneNumber]
    if ([userName isEqualToString:self.curUserInfo.nickName] && self.userIsLogined) {
        return;
    }
    //登录流程
}

/**
 用户下线函数
 
 @param userName 用户名
 @param sucBlock 成功回调
 @param failedBlock 失败回调
 */
- (void)logout:(NSString *)userName sucBlock:(ONE_PARAM_BLOCK)sucBlock failedBlock:(ONE_PARAM_BLOCK)failedBlock{
    if (!self.userIsLogined) {
        return;
    }
    if (![self.curUserInfo.nickName isEqualToString:userName]) {
        return;
    }
    
    //登出操作
}
#pragma mark userInfo method
/**
 更新用户信息
 
 @param userInfo 新的用户信息
 */
- (void)updateUserInfo:(YCUserInfo *)userInfo{
    [self.curUserInfo updateInfo:userInfo];
}

/**
 保存登录信息
 
 @param userName 用户名
 @param password 用户密码1
 @return 保存成功yes 失败NO
 */
- (BOOL)saveLoginInfo:(NSString *)userName password:(NSString *)password{
    if (nil == userName || password == nil) {
        return NO;
    }
    NSError *error;
    if(![SSKeychain setPassword:password forService:[[NSBundle mainBundle] bundleIdentifier] account:userName error:&error]){
        NSLog(@"ERROR : saveLoginInfo error %@", error);
        return NO;
    }
    return YES;
}

- (NSDictionary<NSString *, id> *)getOneLoginInfo{
    NSArray *loginList = [self getAllLoginInfo];
    if (0 >= loginList.count) {
        return nil;
    }
    
    return [loginList firstObject];
}

/**
 获取这个应用的所有登录信息

 @return 数组
 */
- (NSArray<NSDictionary<NSString *, id> *> *)getAllLoginInfo{
    NSArray *tempList = [SSKeychain accountsForService:[[NSBundle mainBundle] bundleIdentifier] error:nil];
    return tempList;
}

/**
 保存当前登录的用户信息
 */
- (void)saveUserInfo{
    if (nil == self.curUserInfo) {
        return;
    }
    NSString *saveJson = [self.curUserInfo yy_modelToJSONString];
    NSString *filePath = [[YCFileManager getDocumentFolderPath] stringByAppendingPathComponent:YCDefLoginUserInfoFileName];
    [YCFileManager writeDataToFile:saveJson path:filePath];
}

/**
 获取前一次登录的用户信息

 @return 用户信息
 */
- (YCUserInfo *)beforeUserInfo{
    NSString *filePath = [[YCFileManager getDocumentFolderPath] stringByAppendingPathComponent:YCDefLoginUserInfoFileName];
    NSData *contentData = [YCFileManager readFileData4FilePath:filePath];
    if (contentData == nil) {
        return nil;
    }
    NSString *jsonStr = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    YCUserInfo *userInfo = [YCUserInfo yy_modelWithJSON:jsonStr];
    return userInfo;
}
@end
