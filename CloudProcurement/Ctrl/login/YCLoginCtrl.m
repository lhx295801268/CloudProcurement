//
//  YCLoginCtrl.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/7.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCLoginCtrl.h"
#import "YCTypeDefObj.h"
#import "UIDevice+MC.h"
@interface YCLoginCtrl ()
//关闭
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong)UIImageView *iconImageView;
@property (nonatomic, strong) UITextField *uNTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UILabel *registTipsLabel;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation YCLoginCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navationbarHidden = YES;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    [self initUI];
}

- (void)initUI{
    UIImageView *backImageView = [UIImageView newAutoLayoutView];
    _backImageView = backImageView;
    [backImageView setImage:YCDefImageWithName(@"close")];
    [self.view addSubview:backImageView];
    [backImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:(YCDefStatusBarHeight+13)];
    
    UIView *accountContentView = [UIView newAutoLayoutView];
    [self.view addSubview:accountContentView];
    [accountContentView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [accountContentView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [accountContentView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    
    UILabel *accountLable = [UILabel newAutoLayoutView];
    accountLable.text = @"账号/手机号: ";
    accountLable.textColor = [UIColor blackColor];
    [accountContentView addSubview:accountLable];
    [accountLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [accountLable autoPinEdgeToSuperviewEdge:ALEdgeLeft ];
    [accountLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    self.uNTextField = [UITextField newAutoLayoutView];
    self.uNTextField.placeholder = @"请输入手机号";
    self.uNTextField.textColor = [UIColor blackColor];
}
@end
