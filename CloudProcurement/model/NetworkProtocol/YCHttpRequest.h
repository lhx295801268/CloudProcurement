//
//  YCHttpRequest.h
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCTypeDefObj.h"
#define __setAttrParam(attr)    (if(nil != self.attr){ self.requestDic setObject:self.attr forKey:__stringif(attr) })
#define __setBaseAttr(attr)    (if(nil != self.attr){ self.requestDic setObject:@(self.attr) forKey:__stringif(attr) })
NS_ASSUME_NONNULL_BEGIN
@interface YCHttpRequest : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) YCHttpRequestMethod requestMethod;
- (NSDictionary *)buildParam2Dic;
- (void)startRequestHttps:(ONE_PARAM_BLOCK)sucBlock failedBlock:(ONE_PARAM_BLOCK)failedBlock;
@end
NS_ASSUME_NONNULL_END
