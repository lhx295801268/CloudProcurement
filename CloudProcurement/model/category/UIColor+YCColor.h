//
//  UIColor+YCColor.h
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/8.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
#define YCColorWithRGBA(color,alphaNumber)   [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alphaNumber];
@interface UIColor(YCColor)
/**
 按钮，icon，栏目背景
 0x26b7bc
 */
+(UIColor *)ycGreen1Color;
/**
 选中按钮，关键字，标题等
 0x00a7b1
 */
+(UIColor *)ycGreen2Color;
/**
 价格文字颜色
 0xfc3b3b
 */
+(UIColor *)ycRed1Color;
/**
 重要级文字信息，标题等
 0x282828
 */
+(UIColor *)ycDeepBlackColor;
/**
 大部分文字 如：列表正文， 默认状态文字，类目文字
 0x585858
 */
+(UIColor *)ycDeepGrayColor;
/**
 一般默认性图标
 0x808080
 */
+(UIColor *)ycDeepGray2Color;
/**
 辅助性，提示性文字
 0x989898
 */
+(UIColor *)ycGray1Color;
/**
 失效图标
 0xb2b2b2
 */
+(UIColor *)ycGray2Color;
/**
 模块建个底色背景
 0xf8f8f8
 */
+(UIColor *)ycLightGray1Color;
/**
 边框线，分割线
 0xe5e5e5
 */
+(UIColor *)ycLightGray2Color;

/**
 有背景色的文字色
 0xffffff
 */
+(UIColor *)ycWhiteColor;
@end

NS_ASSUME_NONNULL_END
