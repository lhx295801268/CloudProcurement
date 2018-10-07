//
//  NSObject+JSInteration.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/9/29.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "NSObject+JSInteration.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "YCNotificationNameConfig.h"
@implementation NSObject (NSObject_JSInteration)
- (void)webView:(id)unuse didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id)frame {
    [[NSNotificationCenter defaultCenter] postNotificationName:YCDef_JSInteration_WebViewJsContext_Notification object:ctx];
}
@end
