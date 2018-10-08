//
//  YCJSInterationBasicObj.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/9/29.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCJSInterationBasicObj.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "YCNotificationNameConfig.h"
@interface YCJSInterationBasicObj()<YCJSinterationPro>
@property (nonatomic, strong) JSContext *jsc;
@end

@implementation YCJSInterationBasicObj
- (instancetype)init{
    if (self = [super init]) {
        self.jsc = [[JSContext alloc] init];
        self.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getJSContextNotification:) name:YCDef_JSInteration_WebViewJsContext_Notification object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)getJSContextNotification:(NSNotification *)notification{
    self.jsc = notification.object;
    if (nil == self.jsc) {
        return;
    }
    if (self.delegate) {
        [_delegate catchJSContextMethod:self.jsc];
    }
}

#pragma mark YCJSinterationPro
- (void)catchJSContextMethod:(JSContext *)jsc{
    NSLog(@"catched JSContext is %@", jsc);
}
@end
