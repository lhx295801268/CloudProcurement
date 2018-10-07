//
//  YCHttpRequest.m
//  ProductionCreateTest
//
//  Created by TsunamiLi on 2018/9/28.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCHttpRequest.h"
//#import <objc/runtime.h>
#import "AFNetworking.h"
#import "YCPathConfig.h"
@interface YCHttpRequest()
@property (nonatomic, strong, readonly) NSMutableDictionary *requestDic;
@property (nonatomic, strong) AFHTTPSessionManager *httpManager;
@property (nonatomic, copy) ONE_PARAM_BLOCK progressBlock;
@property (nonatomic, copy) ONE_PARAM_BLOCK sucBlock;
@property (nonatomic, copy) ONE_PARAM_BLOCK failedBlock;
@end
@implementation YCHttpRequest
- (instancetype)init{
    if (self = [super init]) {
        _requestDic = [[NSMutableDictionary alloc] init];
        self.requestMethod = kYCHttpRequestMethod4Post;
        self.httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        self.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}
- (void)startRequestHttps:(ONE_PARAM_BLOCK)sucBlock failedBlock:(ONE_PARAM_BLOCK)failedBlock {
//    _progressBlock = progressBlock;
    _sucBlock = sucBlock;
    _failedBlock = failedBlock;
    //构建参数
    [self buildParam2Dic];
    NSDictionary *paramDic = self.requestDic;
    //拼接访问的url地址
    NSString *perfectUrl = YCDefRootUrl;
    if (nil != self.url && self.url.length > 0) {
        perfectUrl = [YCDefRootUrl stringByAppendingString: [NSString stringWithFormat:@"/%@", self.url]];
    }
    if (self.requestMethod == kYCHttpRequestMethod4Post) {
        [self.httpManager POST:perfectUrl parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *textStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", textStr);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }else if(self.requestMethod == kYCHttpRequestMethod4Get){
        [self.httpManager GET:perfectUrl parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *textStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", textStr);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }
}
- (void)buildParam2Dic{
//    NSInteger attrCount = 0;
//    objc_property_t *properties = class_copyPropertyList([self class], &attrCount);
}
@end
