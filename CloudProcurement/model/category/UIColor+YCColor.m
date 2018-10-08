//
//  UIColor+YCColor.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/8.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "UIColor+YCColor.h"
#define YCColorImplement(colorName,colorNumber,alpha)    \
+ (UIColor *)colorName{    \
static UIColor* colorName##_color;    \
static dispatch_once_t colorName##_onceToken;   \
dispatch_once(&colorName##_onceToken, ^{    \
colorName##_color = YCColorWithRGBA(colorNumber,alpha);  \
});\
return colorName##_color;  \
}
@implementation UIColor(YCColor)
YCColorImplement(ycGreen1Color, 0x26b7bc, 1);
YCColorImplement(ycGreen2Color, 0x00a7b1, 1);

YCColorImplement(ycRed1Color, 0xfc3b3b, 1);

YCColorImplement(ycDeepBlackColor, 0x282828, 1);

YCColorImplement(ycDeepGrayColor, 0x585858, 1);
YCColorImplement(ycDeepGray2Color, 0x808080, 1);
YCColorImplement(ycGray1Color, 0x989898, 1);
YCColorImplement(ycGray2Color, 0xb2b2b2, 1);
YCColorImplement(ycLightGray1Color, 0xf8f8f8, 1);
YCColorImplement(ycLightGray2Color, 0xe5e5e5, 1);

YCColorImplement(ycWhiteColor, 0xffffff, 1);
@end
