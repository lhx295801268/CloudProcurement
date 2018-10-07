//
//  YCWebViewCtrl.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/9/29.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCWebViewCtrl.h"
#import <WebKit/WebKit.h>
#import "YCJSInterationBasicObj.h"
@interface YCWebViewCtrl ()<YCJSinterationPro>
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) YCJSInterationBasicObj *jsInterationBasicObj;
@property (nonatomic, strong)  UIWebView *webView;
@property (nonatomic, strong) WKWebView *wkWebView;
@end

@implementation YCWebViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.jsInterationBasicObj = [[YCJSInterationBasicObj alloc] init];
    self.jsInterationBasicObj.delegate = self;
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initUI{
    self.webView = [UIWebView newAutoLayoutView];
    [self.view addSubview:self.webView];
    [self.webView autoPinEdgesToSuperviewEdges];
}

- (void)initUI4Ios12{
    self.wkWebView = [WKWebView newAutoLayoutView];
}
#pragma mark YCJSinterationPro
- (void)catchJSContextMethod:(JSContext *)jsc{
    NSString *indentifier = [NSString stringWithFormat:@"indentifier%lud", (unsigned long)self.webView.hash];
//    NSString *indentifierJS = [NSString stringWithFormat:@"var %@ = '%@'", indentifier, indentifier];
//    //oc调用js的函数？
//    [self.webView stringByEvaluatingJavaScriptFromString:indentifierJS];
    //判断这个context是否属于当前这个webView
    if (![jsc[indentifier].toString isEqualToString:indentifier]) return;
    _jsContext = jsc;     //如果属于这个webView
    jsc[NSStringFromClass([self class])] = self;    //将对象注入这个context中
}

- (void)clickJumpChildWebBtnMethod:(NSString *)childUrl{
    
}

- (void)appCtrlJump:(NSString *)ctrlName{
    
}
@end
