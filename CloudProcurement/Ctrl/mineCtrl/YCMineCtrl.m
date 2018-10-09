//
//  YCMineCtrl.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/9.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCMineCtrl.h"
#import "YCLoginCtrl.h"
@interface YCMineCtrl ()
@property (nonatomic, strong)YCLoginCtrl *loginCtrl;
@end

@implementation YCMineCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navationbarHidden = YES;
    [self initData];
}

- (void)initData{
    if (![[YCUserManager shareIns] isLogined]) {
        YCLoginCtrl *loginCtrl = [[YCLoginCtrl alloc] init];
        _loginCtrl = loginCtrl;
        [self addChildViewController:loginCtrl];
        [self.view addSubview:loginCtrl.view];
    }else{
        [self initUI];
        [self reqData];
    }
}
- (void)initUI{
    
}
- (void)reqData{
    
}

- (void)bindEvent{
    
}
@end
