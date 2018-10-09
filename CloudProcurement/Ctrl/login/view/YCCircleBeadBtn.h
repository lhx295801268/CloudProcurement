//
//  YCCircleBeadBtn.h
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/9.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCCircleBeadBtn : UIButton

/**
 创建一个圆角按钮
 宽高布局需要外部定义
 @param disableBgColor 不能点击的时候的背景颜色 nil 默认颜色 0x7ae1e3
 @param enableBgColor 可点击之后的背景颜色 nil 默认颜色 ycGreen1Color
 @param title 标题
 @param cr 圆角半径
 @return YCCircleBeadBtn
 */
+(instancetype)createBtnWithAttr:(UIColor *)disableBgColor enableBgColor:(UIColor *)enableBgColor title:(NSString *)title cr:(CGFloat )cr;
@end
