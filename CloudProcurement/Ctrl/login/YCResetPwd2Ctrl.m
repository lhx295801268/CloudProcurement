//
//  YCResetPwd2Ctrl.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/8.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCResetPwd2Ctrl.h"
#import "YCCircleBeadBtn.h"
@interface YCResetPwd2Ctrl ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *setPwdTextField;
@property (nonatomic, strong) UITextField *againPwdTextField;
@property (nonatomic, strong) YCCircleBeadBtn *saveBtn;
@end

@implementation YCResetPwd2Ctrl
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor ycWhiteColor];
    self.title = @"找回密码";
    [self initUI];
    [self bindEvent];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFeledChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self hiddenKeyboard];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initUI{
    NSDictionary *tempDic = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor ycDeepGrayColor], NSStrokeColorAttributeName:[UIColor ycDeepGrayColor]};
    UITextField *setPwdTextField = [UITextField newAutoLayoutView];
    _setPwdTextField = setPwdTextField;
    setPwdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"设置密码" attributes:tempDic];
    setPwdTextField.textColor = [UIColor ycDeepGrayColor];
    setPwdTextField.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:setPwdTextField];
    [setPwdTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:YCDefNavTitleViewHeight];
    [setPwdTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [setPwdTextField autoSetDimension:ALDimensionHeight toSize:55];
    [setPwdTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:25];
    
    UIView *firstLineView = [UIView newAutoLayoutView];
    firstLineView.backgroundColor = [UIColor ycLightGray2Color];
    [self.view addSubview:firstLineView];
    [firstLineView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:setPwdTextField];
    [firstLineView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:setPwdTextField];
    [firstLineView autoSetDimension:ALDimensionHeight toSize:1];
    [firstLineView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:setPwdTextField];
    
    UIView *verifyContentView = [UIView newAutoLayoutView];
    [self.view addSubview:verifyContentView];
    [verifyContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:firstLineView];
    [verifyContentView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:firstLineView];
    [verifyContentView autoSetDimension:ALDimensionHeight toSize:55];
    [verifyContentView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:firstLineView];
    
    UITextField *againPwdTextField = [UITextField newAutoLayoutView];
    _againPwdTextField = againPwdTextField;
    againPwdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"确认密码" attributes:tempDic];
    againPwdTextField.textColor = setPwdTextField.textColor;
    againPwdTextField.font = setPwdTextField.font;
    [verifyContentView addSubview:againPwdTextField];
    [againPwdTextField autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [againPwdTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [againPwdTextField autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [againPwdTextField autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    setPwdTextField.delegate = self;
    setPwdTextField.secureTextEntry = YES;
    againPwdTextField.delegate = self;
    againPwdTextField.secureTextEntry = YES;
    
    UIView *bottomLineView = [UIView newAutoLayoutView];
    [verifyContentView addSubview:bottomLineView];
    bottomLineView.backgroundColor = [UIColor ycLightGray2Color];
    [bottomLineView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [bottomLineView autoSetDimension:ALDimensionHeight toSize:1];
    
    YCCircleBeadBtn *saveBtn = [YCCircleBeadBtn createBtnWithAttr:nil enableBgColor:nil title:@"保 存" cr:20];
    saveBtn.enabled = NO;
    [self.view addSubview:saveBtn];
    [saveBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:verifyContentView withOffset:30];
    [saveBtn autoSetDimension:ALDimensionHeight toSize:40];
    [saveBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [saveBtn autoPinEdgeToSuperviewEdge:ALEdgeRight  withInset:25];
    _saveBtn = saveBtn;
}

- (void)bindEvent{
    @weakify(self);
    [self.view addTapGesterTouchMethod:^(id  _Nonnull aparam) {
        [self_weak_ hiddenKeyboard];
    }];
    [self.saveBtn addTarget:self action:@selector(clicksaveBtn) forControlEvents:UIControlEventTouchUpInside];
}
- (void)hiddenKeyboard{
    [self.setPwdTextField resignFirstResponder];
    [self.againPwdTextField resignFirstResponder];
}
- (void)clicksaveBtn{
    //跳转下一步
#warning add by lhx 保存、修改密码请求
    NSLog(@"保存密码：%@", NSStringFromClass([self class]));
    [self popCtrl4FlowName:YCDefResetPwdFlowName];
}
#pragma mark textField change rac
- (void)textFeledChange:(NSNotification *)notification{
    self.saveBtn.enabled = (self.setPwdTextField.text.length > 0) && (self.againPwdTextField.text.length > 0);
}
#pragma mark keyboadHidden or show ?
//- (void)
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
