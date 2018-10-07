//
//  YCTypeDefObj.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//
#define __stringif(x) @#x

#define YCDefScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define YCDefScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define YCDefImageWithName(name) ((name == nil || name.length <= 0) ? (nil) : ([UIImage imageNamed:imageName]))
//系统版本号
#define YCDefSysVersion ([UIDevice currentDevice].systemVersion)
//系统版本号12以后
#define YCDefSysVersion_IOS12_After (YCDefSysVersion.doubleValue > 12.0)
//系统版本号10以后
#define YCDefSysVersion_IOS10_After (YCDefSysVersion.doubleValue > 10.0)

//屏幕尺寸
typedef void (^ONE_PARAM_BLOCK)(id __nullable param);
typedef void (^TWO_PARAM_BLOCK)(id __nullable param1, id __nullable param2);

typedef NS_ENUM(NSInteger, YCHttpRequestMethod) {
    kYCHttpRequestMethod4Post = 0,
    kYCHttpRequestMethod4Get,
    kYCHttpRequestMethod4Delete
};
