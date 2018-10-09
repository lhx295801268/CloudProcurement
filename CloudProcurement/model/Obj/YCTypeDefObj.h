//
//  YCTypeDefObj.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//
#define __stringif(x) @#x
#define YCDefIphoneXLaterBottomHeight ((![UIDevice+MC isIphoneXOrLater]) ? (0) : (34))
#define YCDefStatusBarHeight ((![UIDevice isIphoneXOrLater]) ? (20) : (44))
#define YCDefNavTitleViewHeight ((![UIDevice isIphoneXOrLater]) ? (64) : (104))

#define YCDefScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define YCDefScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define YCDefImageWithName(_imageName) [UIImage imageNamed:_imageName]
//系统版本号
#define YCDefSysVersion ([UIDevice currentDevice].systemVersion)
//系统版本号12以后
#define YCDefSysVersion_IOS12_After (YCDefSysVersion.doubleValue > 12.0)
//系统版本号10以后
#define YCDefSysVersion_IOS10_After (YCDefSysVersion.doubleValue > 10.0)

//屏幕尺寸
typedef void (^ONE_PARAM_BLOCK)(id __nullable param);
typedef void (^TWO_PARAM_BLOCK)(id __nullable param1, id __nullable param2);

/**
 网络请求类型
 */
typedef NS_ENUM(NSInteger, YCHttpRequestMethod) {
    kYCHttpRequestMethod4Post = 0,
    kYCHttpRequestMethod4Get,
    kYCHttpRequestMethod4Delete
};

/**
 iphone 手机型号枚举
 */
typedef NS_ENUM(NSInteger, YCIphoneType) {
//    表示已经淘汰的机型 或者 不支持的机型
    kYCIphoneTypeForNormal = 0,
    kYCIphoneTypeFor4 = 40,
    kYCIphoneTypeFor4S ,
    kYCIphoneTypeFor5 = 50,
    kYCIphoneTypeFor5C,
    kYCIphoneTypeFor5S,
    kYCIphoneTypeFor6 = 60,
    kYCIphoneTypeFor6P,
    kYCIphoneTypeFor6S,
    kYCIphoneTypeFor6SP,
    kYCIphoneTypeForSE = 65,
    kYCIphoneTypeFor7 = 70,
    kYCIphoneTypeFor7P,
    kYCIphoneTypeFor8 = 80,
    kYCIphoneTypeFor8P,
    kYCIphoneTypeForX = 100,
    kYCIphoneTypeForXR,
    kYCIphoneTypeForXS,
    kYCIphoneTypeForXSM
};
