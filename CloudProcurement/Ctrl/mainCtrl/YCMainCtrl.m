//
//  YCMainCtrl.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/8.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCMainCtrl.h"
#import "YCWebViewCtrl.h"
@interface YCMainCtrl ()
@property (nonatomic, strong) YCWebViewCtrl *webCtrl;
@end

@implementation YCMainCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navationbarHidden = YES;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    [self initUI];
}
- (void)initUI{
    self.webCtrl = [[YCWebViewCtrl alloc]init];
    [self addChildViewController:self.webCtrl];
    [self.view addSubview:self.webCtrl.view];
    [self.webCtrl.view autoPinEdgesToSuperviewEdges];
    self.webCtrl.reqUrlStr = @"http://m.yuncai998.com";
}

@end
