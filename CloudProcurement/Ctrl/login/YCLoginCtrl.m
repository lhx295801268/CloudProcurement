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
#import "UIColor+YCColor.h"
@interface YCLoginCtrl ()
//关闭
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong)UIImageView *iconImageView;
@property (nonatomic, strong) UITextField *uNTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UILabel *forgotPwdTipsLabel;
@property (nonatomic, strong) UILabel *registTipsLabel;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation YCLoginCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navationbarHidden = YES;
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI{
    UIImageView *backImageView = [UIImageView newAutoLayoutView];
    _backImageView = backImageView;
    [backImageView setImage:YCDefImageWithName(@"close")];
    [self.view addSubview:backImageView];
    [backImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:(YCDefStatusBarHeight+13)];
    [backImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    
    UIImageView *iconImageView = [UIImageView newAutoLayoutView];
    [self.view addSubview:iconImageView];
    _iconImageView = iconImageView;
    [iconImageView setImage:YCDefImageWithName(@"login_logo")];
    [iconImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [iconImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:backImageView withOffset:(45.5)];
    
    UIView *contentView = [UIView newAutoLayoutView];
    [self.view addSubview:contentView];
    [contentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:iconImageView withOffset:61];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:25];
    
    self.uNTextField = [UITextField newAutoLayoutView];
    NSString *placeHolderStr = @"用户名";
    NSMutableAttributedString *phAttrStr = [[NSMutableAttributedString alloc] initWithString:placeHolderStr];
    NSDictionary *tempDic = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor ycDeepGrayColor], NSStrokeColorAttributeName:[UIColor ycDeepGrayColor]};
    [phAttrStr addAttributes:tempDic range:NSRangeFromString(placeHolderStr)];
    self.uNTextField.attributedPlaceholder = phAttrStr;
    self.uNTextField.textColor = [UIColor ycDeepGrayColor];
    self.uNTextField.font = [UIFont systemFontOfSize:16];
    [contentView addSubview:self.uNTextField];
    [self.uNTextField autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.uNTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.uNTextField autoSetDimension:ALDimensionHeight toSize:45];
    [self.uNTextField autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UIView *upLineView = [UIView newAutoLayoutView];
    [contentView addSubview:upLineView];
    upLineView.backgroundColor = [UIColor ycLightGray2Color];
    [upLineView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.uNTextField];
    [upLineView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [upLineView autoSetDimension:ALDimensionHeight toSize:1];
    [upLineView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UIView *pwdContentView = [UIView newAutoLayoutView];
    [contentView addSubview:pwdContentView];
    [pwdContentView autoSetDimension:ALDimensionHeight toSize:55];
    [pwdContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:upLineView];
    [pwdContentView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [pwdContentView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [pwdContentView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UITextField *pwdTextField = [UITextField newAutoLayoutView];
    [pwdContentView addSubview:pwdTextField];
    _pwdTextField = pwdTextField;
    pwdTextField.textColor = [UIColor ycDeepGrayColor];
    NSString *tempPwdStr = @"密码";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:tempPwdStr attributes:tempDic];
    pwdTextField.attributedPlaceholder = attrStr;
    
    UILabel *forgotPwdTipsLabel = [UILabel newAutoLayoutView];
    forgotPwdTipsLabel.textColor = [UIColor ycGray1Color];
    forgotPwdTipsLabel.font = [UIFont systemFontOfSize:12];
    forgotPwdTipsLabel.text = @"忘记密码";
    _forgotPwdTipsLabel = forgotPwdTipsLabel;
    [pwdContentView addSubview:forgotPwdTipsLabel];
    [forgotPwdTipsLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [forgotPwdTipsLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    [pwdTextField autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [pwdTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [pwdTextField autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [pwdTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:forgotPwdTipsLabel withOffset:(-10)];

    UIView *bottomLineView = [UIView newAutoLayoutView];
    [pwdContentView addSubview:bottomLineView];
    bottomLineView.backgroundColor = [UIColor ycLightGray2Color];
    [bottomLineView autoSetDimension:ALDimensionHeight toSize:1];
    [bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UIButton *loginBtn = [UIButton newAutoLayoutView];
    [self.view addSubview:loginBtn];
    _loginBtn = loginBtn;
    loginBtn.layer.cornerRadius = 20;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor ycWhiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:0x7a green:0xe1 blue:0xe3 alpha:1]];
    [loginBtn autoSetDimension:ALDimensionHeight toSize:40];
    [loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:contentView withOffset:30];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:25];
    
    UIView *tipsContentView = [UIView newAutoLayoutView];
    [self.view addSubview:tipsContentView];
    [tipsContentView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [tipsContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:15];
    
    UILabel *tipsOneLable = [UILabel newAutoLayoutView];
    tipsOneLable.text = @"还没有账号？";
    tipsOneLable.font = [UIFont systemFontOfSize:12];
    tipsOneLable.textColor = [UIColor ycGray1Color];
    [tipsContentView addSubview:tipsOneLable];
    [tipsOneLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [tipsOneLable autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [tipsOneLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    UILabel *mustRegistLabel = [UILabel newAutoLayoutView];
    _registTipsLabel = mustRegistLabel;
    _registTipsLabel.textColor = [UIColor ycDeepGrayColor];
    mustRegistLabel.text = @"立即注册";
    mustRegistLabel.font = [UIFont systemFontOfSize:12];
    [tipsContentView addSubview:mustRegistLabel];
    [mustRegistLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [mustRegistLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:tipsOneLable withOffset:0];
    [mustRegistLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [mustRegistLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    @weakify(self);
    [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [self_weak_.forgotPwdTipsLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
        [self_weak_.forgotPwdTipsLabel autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
    }];
}

- (void)bindEvent{
    
}
@end
