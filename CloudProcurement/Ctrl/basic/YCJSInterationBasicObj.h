//
//  YCJSInterationBasicObj.h
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/9/29.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "YCTypeDefObj.h"
NS_ASSUME_NONNULL_BEGIN
@protocol YCJSinterationPro <JSExport>

/**
 javascrip抓取javascripContext对象

 @param jsc 抓取到的对象
 */
- (void)catchJSContextMethod:(JSContext *)jsc;
@optional

/**
 点击按钮或者其他触发界面跳转的函数

 @param childUrl url地址
 */
- (void)clickJumpChildWebBtnMethod:(NSString *)childUrl;

/**
 app内部跳转j触发

 @param ctrlName 跳转界面的界面名称
 */
- (void)appCtrlJump:(NSString *)ctrlName;
@end

@interface YCJSInterationBasicObj : NSObject
@property (nonatomic, weak) id<YCJSinterationPro> delegate;

@end

NS_ASSUME_NONNULL_END
