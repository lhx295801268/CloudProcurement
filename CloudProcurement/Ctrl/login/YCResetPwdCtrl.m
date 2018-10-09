//
//  YCResetPwdCtrl.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/8.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCResetPwdCtrl.h"
#import "YCCircleBeadBtn.h"
#import "YCResetPwd2Ctrl.h"
@interface YCResetPwdCtrl ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UILabel *resendLabel;
@property (nonatomic, strong) UITextField *verifyCodeTextField;
@property (nonatomic, strong) YCCircleBeadBtn *nextBtn;

@property (nonatomic, strong) NSTimer *codeTimer;
@property (nonatomic, assign) BOOL isStartCountTime;
@property (nonatomic, assign) NSInteger timesCount;
@end

@implementation YCResetPwdCtrl

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
    UITextField *phoneNumberTextField = [UITextField newAutoLayoutView];
    _phoneNumberTextField = phoneNumberTextField;
    phoneNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:tempDic];
    phoneNumberTextField.textColor = [UIColor ycDeepGrayColor];
    phoneNumberTextField.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:phoneNumberTextField];
    [phoneNumberTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:YCDefNavTitleViewHeight];
    [phoneNumberTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [phoneNumberTextField autoSetDimension:ALDimensionHeight toSize:55];
    [phoneNumberTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:25];
    
    UIView *firstLineView = [UIView newAutoLayoutView];
    firstLineView.backgroundColor = [UIColor ycLightGray2Color];
    [self.view addSubview:firstLineView];
    [firstLineView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:phoneNumberTextField];
    [firstLineView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:phoneNumberTextField];
    [firstLineView autoSetDimension:ALDimensionHeight toSize:1];
    [firstLineView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:phoneNumberTextField];
    
    UIView *verifyContentView = [UIView newAutoLayoutView];
    [self.view addSubview:verifyContentView];
    [verifyContentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:firstLineView];
    [verifyContentView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:firstLineView];
    [verifyContentView autoSetDimension:ALDimensionHeight toSize:55];
    [verifyContentView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:firstLineView];
    
    UILabel *resendLabel = [UILabel newAutoLayoutView];
    _resendLabel = resendLabel;
    resendLabel.textColor = [UIColor ycGreen2Color];
    resendLabel.text = @"重新发送";
    resendLabel.font = [UIFont systemFontOfSize:12];
    [verifyContentView addSubview:resendLabel];
    [resendLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [resendLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UITextField *verifyCodeTextField = [UITextField newAutoLayoutView];
    _verifyCodeTextField = verifyCodeTextField;
    verifyCodeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"验证码" attributes:tempDic];
    verifyCodeTextField.textColor = phoneNumberTextField.textColor;
    verifyCodeTextField.font = phoneNumberTextField.font;
    [verifyContentView addSubview:verifyCodeTextField];
    [verifyCodeTextField autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [verifyCodeTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [verifyCodeTextField autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [verifyCodeTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:resendLabel withOffset:5];
    
    phoneNumberTextField.delegate = self;
    verifyCodeTextField.delegate = self;
    
    UIView *bottomLineView = [UIView newAutoLayoutView];
    [verifyContentView addSubview:bottomLineView];
    bottomLineView.backgroundColor = [UIColor ycLightGray2Color];
    [bottomLineView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [bottomLineView autoSetDimension:ALDimensionHeight toSize:1];
    
    YCCircleBeadBtn *nextBtn = [YCCircleBeadBtn createBtnWithAttr:nil enableBgColor:nil title:@"下一部" cr:20];
    nextBtn.enabled = NO;
    [self.view addSubview:nextBtn];
    [nextBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:verifyContentView withOffset:30];
    [nextBtn autoSetDimension:ALDimensionHeight toSize:40];
    [nextBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [nextBtn autoPinEdgeToSuperviewEdge:ALEdgeRight  withInset:25];
    _nextBtn = nextBtn;
    @weakify(self);
    [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [self_weak_.resendLabel autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
    }];
}

- (void)bindEvent{
    @weakify(self);
    [RACObserve(self, isStartCountTime) subscribeNext:^(id  _Nullable x) {
        self_weak_.resendLabel.textColor = [x boolValue] ? ([UIColor ycGray1Color]) : ([UIColor ycGreen2Color]);
    }];
    [self.view addTapGesterTouchMethod:^(id  _Nonnull aparam) {
        [self_weak_ hiddenKeyboard];
    }];
    [self.nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.resendLabel addTapGesterTouchMethod:^(id  _Nonnull aparam) {
        if (self_weak_.isStartCountTime) {
            return;
        }
        [self_weak_ createCodeTimer];
    }];
}

- (void)createCodeTimer{
    [self stopTimer];
    self.timesCount = 60;
    self.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    self.isStartCountTime = YES;
    [self.codeTimer fire];
}

- (void)stopTimer{
    if (nil != self.codeTimer) {
        [self.codeTimer invalidate];
        self.codeTimer = nil;
        self.timesCount = 60;
        self.resendLabel.text = @"重新发送";
    }
}

- (void)timerMethod{
    self.timesCount--;
    if (self.timesCount < 0) {
        self.isStartCountTime = NO;
        [self stopTimer];
    }else{
        NSString *timeStr = [NSString stringWithFormat:@"%@s后重新发送", @(self.timesCount)];
        self.resendLabel.text = timeStr;
    }
}

- (void)hiddenKeyboard{
    [self.phoneNumberTextField resignFirstResponder];
    [self.verifyCodeTextField resignFirstResponder];
}

- (void)clickNextBtn{
    //跳转下一步
    YCResetPwd2Ctrl *ctrl = [[YCResetPwd2Ctrl alloc] initWithFlowName:YCDefResetPwdFlowName];
    [self gotoNextCtrl:ctrl];
}
#pragma mark textField change rac
- (void)textFeledChange:(NSNotification *)notification{
    self.nextBtn.enabled = (self.phoneNumberTextField.text.length > 0) && (self.verifyCodeTextField.text.length > 0);
}
#pragma mark keyboadHidden or show ?
//- (void)
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
