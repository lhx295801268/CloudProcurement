//
//  YCRegistCtrl.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/8.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCRegistCtrl.h"
#import "YCCircleBeadBtn.h"
@interface YCRegistCtrl ()<UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *bgView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UITextField *verifyCodeTextField;
@property (nonatomic, strong) UITextField *setPwdTextField;
@property (nonatomic, strong) UITextField *againPwdTextField;
@property (nonatomic, strong) UITextField *companyNameTextField;
@property (nonatomic, strong) UILabel *sendCodeLabel;
@property (nonatomic, strong) YCCircleBeadBtn *registBtn;

@property (nonatomic, strong) UITextField *curEditTextFiled;
@end

@implementation YCRegistCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor ycLightGray1Color];
    self.title = @"注册";
    [self initUI];
    [self bindEvent];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangeText:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initUI{
    UIScrollView *bgView = [UIScrollView newAutoLayoutView];
    _bgView = bgView;
    [self.view addSubview:bgView];
    [bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:YCDefNavTitleViewHeight];
    [bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UIView *contentView = [UIView newAutoLayoutView];
    _contentView = contentView;
    [bgView addSubview:contentView];
    [contentView autoSetDimensionsToSize:CGSizeMake(YCDefScreenWidth, YCDefScreenHeight - YCDefNavTitleViewHeight)];
    [contentView autoPinEdgesToSuperviewEdges];
    
    UIView *phoneNumberTextField =[self createItemContentView:@"手机号"];
    [contentView addSubview:phoneNumberTextField];
    phoneNumberTextField.backgroundColor = [UIColor ycWhiteColor];
    [phoneNumberTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:(15)];
    [phoneNumberTextField autoSetDimension:ALDimensionHeight toSize:39];
    [phoneNumberTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [phoneNumberTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    
    UIView *secondContentView = [UIView newAutoLayoutView];
    [self.view addSubview:secondContentView];
    [secondContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumberTextField withOffset:15];
    [secondContentView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:phoneNumberTextField];
    [secondContentView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:phoneNumberTextField];
    
    UILabel *sendCodeLabel = [UILabel newAutoLayoutView];
    _sendCodeLabel = sendCodeLabel;
    sendCodeLabel.backgroundColor = [UIColor ycGray2Color];
    sendCodeLabel.textColor = [UIColor ycWhiteColor];
    sendCodeLabel.font = [UIFont systemFontOfSize:12];
    sendCodeLabel.text = @"发送验证码";
    sendCodeLabel.textAlignment = NSTextAlignmentCenter;
    [secondContentView addSubview:sendCodeLabel];
    [sendCodeLabel autoSetDimensionsToSize:CGSizeMake(103, 39)];
    [sendCodeLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
    
    UIView *verifyCodeTextField = [self createItemContentView:@"验证码"];
    [secondContentView addSubview:verifyCodeTextField];
    [verifyCodeTextField autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
    [verifyCodeTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:sendCodeLabel withOffset:10];
    
    UIView *setPwdTextField = [self createItemContentView:@"设置密码"];
    [self.view addSubview:setPwdTextField];
    [setPwdTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:secondContentView withOffset:15];
    [setPwdTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:phoneNumberTextField];
    [setPwdTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:phoneNumberTextField];
    [setPwdTextField autoSetDimension:ALDimensionHeight toSize:38];
    [setPwdTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:phoneNumberTextField];
    
    UIView *againPwdTextField = [self createItemContentView:@"确认密码"];
    [self.view addSubview:againPwdTextField];
    [againPwdTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:setPwdTextField withOffset:15];
    [againPwdTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:phoneNumberTextField];
    [againPwdTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:phoneNumberTextField];
    [againPwdTextField autoSetDimension:ALDimensionHeight toSize:38];
    [againPwdTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:phoneNumberTextField];
    
    UIView *companyNameTextField = [self createItemContentView:@"企业名称"];
    [self.view addSubview:companyNameTextField];
    [companyNameTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:againPwdTextField withOffset:15];
    [companyNameTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:phoneNumberTextField];
    [companyNameTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:phoneNumberTextField];
    [companyNameTextField autoSetDimension:ALDimensionHeight toSize:38];
    [companyNameTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:phoneNumberTextField];
    
    YCCircleBeadBtn *registBtn = [YCCircleBeadBtn createBtnWithAttr:[UIColor ycGray2Color] enableBgColor:[UIColor ycGreen1Color] title:@"注 册" cr:1];
    registBtn.enabled = NO;
    _registBtn = registBtn;
    [self.view addSubview:registBtn];
    [registBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:companyNameTextField withOffset:15];
    [registBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:phoneNumberTextField];
    [registBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:phoneNumberTextField];
    [registBtn autoSetDimension:ALDimensionHeight toSize:40];
    @weakify(self);
    [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [self_weak_.sendCodeLabel autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
        [self_weak_.sendCodeLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    }];
}

- (UIView *)createItemContentView:(NSString *)placeHolderStr{
    UIView *itemContentView = [UIView newAutoLayoutView];
    itemContentView.backgroundColor = [UIColor ycWhiteColor];
    
    UITextField *tempTextField = [self createTextField:placeHolderStr];
    if ([placeHolderStr isEqualToString:@"手机号"]) {
        _phoneNumberTextField = tempTextField;
    }else if ([placeHolderStr isEqualToString:@"验证码"]) {
        _verifyCodeTextField = tempTextField;
    }else if ([placeHolderStr isEqualToString:@"设置密码"]) {
        _setPwdTextField = tempTextField;
        tempTextField.secureTextEntry = YES;
    }else if ([placeHolderStr isEqualToString:@"确认密码"]) {
        _againPwdTextField = tempTextField;
        tempTextField.secureTextEntry = YES;
    }else if ([placeHolderStr isEqualToString:@"企业名称"]) {
        _companyNameTextField = tempTextField;
    }
    [itemContentView addSubview:tempTextField];
    [tempTextField autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [tempTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [tempTextField autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [tempTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    return itemContentView;
}

- (UITextField *)createTextField:(NSString *)placeHolder{
    NSDictionary *tempDic = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSStrokeColorAttributeName:[UIColor ycGray1Color], NSForegroundColorAttributeName:[UIColor ycGray1Color]};
    UITextField *resultTextField =[ UITextField newAutoLayoutView];
    resultTextField.textColor = [UIColor ycGray1Color];
    resultTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:tempDic];
    resultTextField.delegate = self;
    resultTextField.returnKeyType = UIReturnKeyDone;
    resultTextField.backgroundColor = [UIColor ycWhiteColor];
    return resultTextField;
}

- (void)bindEvent{
    @weakify(self);
    [self.view addTapGesterTouchMethod:^(id  _Nonnull aparam) {
        [self_weak_ textFiledResignFirstResponder];
    }];
}

- (void)textFiledResignFirstResponder{
    [self.phoneNumberTextField resignFirstResponder];
    [self.verifyCodeTextField resignFirstResponder];
    [self.setPwdTextField resignFirstResponder];
    [self.againPwdTextField resignFirstResponder];
    [self.companyNameTextField resignFirstResponder];
    self.curEditTextFiled = nil;
}

#pragma mark observ method
- (void)textFieldChangeText:(NSNotification *)notification{
    self.registBtn.enabled = (self.phoneNumberTextField.text.length > 0) && (self.verifyCodeTextField.text.length > 0) && (self.setPwdTextField.text.length > 0) && (self.againPwdTextField.text.length > 0) && (self.companyNameTextField.text.length > 0);
}

- (void)keyboardWillHidden:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    CGFloat duration = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    @weakify(self);
    [UIView animateWithDuration:duration animations:^{
        self_weak_.bgView.contentOffset = CGPointMake(0, 0);
    } completion:nil];
    self.curEditTextFiled = nil;
}

- (void)keyboardWillShow:(NSNotification *)notification{
    if (nil == self.curEditTextFiled) {
        return;
    }
    NSDictionary *dic = notification.userInfo;
    CGFloat duration = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect frameRect = [((NSValue *)[dic objectForKey:UIKeyboardFrameEndUserInfoKey]) CGRectValue];
    if (frameRect.origin.y < (self.curEditTextFiled.frame.origin.y + YCDefNavTitleViewHeight)) {
        CGFloat devalue = (self.curEditTextFiled.frame.origin.y + YCDefNavTitleViewHeight) - frameRect.origin.y;
        @weakify(self);
        [UIView animateWithDuration:duration animations:^{
            self_weak_.bgView.contentOffset = CGPointMake(0, devalue);
        } completion:nil];
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.curEditTextFiled = textField;
    return YES;
}
@end
