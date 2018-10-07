//
//  YCUserInfo.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCUserInfo.h"

@implementation YCUserInfo
- (void)updateInfo:(YCUserInfo *)info{
    if (nil == info) {
        return;
    }
    self.nickName = info.nickName;
    self.avartStr = info.avartStr;
    self.phoneNumber = info.phoneNumber;
}
@end
