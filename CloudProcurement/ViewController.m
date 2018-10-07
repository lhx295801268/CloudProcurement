//
//  ViewController.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/9/29.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "ViewController.h"
#import "YCTypeDefObj.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIWebView+AFNetworking.h>

#import "PureLayout.h"
@interface ViewController ()
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIWebView *oldWebView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.oldWebView = [UIWebView newAutoLayoutView];
    [self.view addSubview:self.oldWebView];
    [self.oldWebView autoPinEdgesToSuperviewEdges];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.3.162:9097/"]];
    [self.oldWebView loadRequest:req];
    id temp = [self.oldWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
//    self.webView = [[WKWebView alloc] init];
//    [self.view addSubview:self.webView];
//    self.webView.frame = CGRectMake(0, 0, YCDefScreenWidth, YCDefScreenHeight);
//    [self.webView loadRequest:req];
}


@end
