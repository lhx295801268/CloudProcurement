//
//  YCSysCtrl.m
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/25.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCSysCtrl.h"
@interface YCSysCtrl ()
@property (nonatomic, weak)UINavigationController *navCtrl;
@property (nonatomic, strong) UIButton *backBtn;
@end

@implementation YCSysCtrl
-(instancetype)initWithFlowName:(NSString *)flowName{
    if (self  = [super init]) {
        if((nil == flowName) || (flowName.length <= 0)) {
            flowName = NSStringFromClass([self class]);
        }
        _flowName = flowName;
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _isAppear = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _isAppear = YES;
    if(nil != self.navCtrl){
//        NSLog(@"当前%@标题栏位控制状态%@", NSStringFromClass([self class]), @(self.navationbarHidden));
        [self.navCtrl setNavigationBarHidden:self.navationbarHidden animated:NO];
    }else{
        [self setNavCtrl:(UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController];
       [self.navCtrl setNavigationBarHidden:self.navationbarHidden animated:NO];
    }
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    if (nil == self.backBtn) {
        self.backBtn = [self createBackBtn];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
        [self.backBtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)onBack{
    if (nil != self.navCtrl) {
        [self.navCtrl popViewControllerAnimated:YES];
    }
}
- (UIButton *)createBackBtn{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [backBtn setTitle:@"返 回" forState:UIControlStateNormal];
    UIImage* sourceImage = YCDefImageWithName(@"back");
//    UIImage* flippedImage = [UIImage imageWithCGImage:sourceImage.CGImage
//                                                scale:sourceImage.scale
//                                          orientation:UIImageOrientationUpMirrored];
    [backBtn setImage:sourceImage forState:UIControlStateNormal];
    return backBtn;
}
-(void)setFlowName:(NSString *)flowName{
    if((nil == flowName) || (flowName.length <= 0)) {
        flowName = NSStringFromClass([self class]);
    }
    _flowName = flowName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [RACObserve(self, titleStr) subscribeNext:^(NSString *  _Nullable x) {
        if (nil != self_weak_.navCtrl) {
            //标题设置
            self_weak_.navCtrl.navigationBar.titleTextAttributes =@{NSStrokeColorAttributeName:[UIColor blackColor],NSForegroundColorAttributeName:[UIColor blackColor]};
            [self_weak_.navCtrl setTitle:x];
        }
    }];
}
- (void)gotoNextCtrl:(YCSysCtrl *)desCtrl{
    if (nil == desCtrl) {
        return;
    }
    if(nil == self.navCtrl){
        [self createNavigationCtrl];
    }
    [desCtrl setNavCtrl:self.navCtrl];
    [self.navCtrl pushViewController:desCtrl animated:YES];
}

- (void)gotoNextCtrlAndClearFlows:(YCSysCtrl *)desCtrl flowList:(NSArray<NSString *>*)flowList{
    if (nil == desCtrl) {
        return;
    }
//    先跳转在进行移除操作
    [self gotoNextCtrl:desCtrl];
    [self clearFlow:flowList];
}

-(void)popCtrl4FlowName:(NSString *)flowName{
    if(flowName.length <= 0) return;
    [self clearFlow:@[flowName]];
}

-(void)createNavigationCtrl{
    UINavigationController *navCtrl = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    if (nil == navCtrl) {
         UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:self];
        [UIApplication sharedApplication].delegate.window.rootViewController = navCtrl;
    }
    self.navCtrl = navCtrl;
}
- (void)setNavCtrl:(UINavigationController *)navCtrl{
    _navCtrl = navCtrl;
}

/**
 设置标题栏
 */
-(void)setNavTitleView{
    
}

#pragma mark 警告框弹出?
- (UIAlertController *)showAlertView:(NSString *)titleString bodyStr:(NSString *)bodyStr clickBlock:(ONE_PARAM_BLOCK)clickBlock{
    UIAlertController *alertCtrl = [self showAlertWithActions:@[@"取消"] titleStr:titleString bodyStr:bodyStr clickBlock:clickBlock];
    return alertCtrl;
}

-(UIAlertController *)showAlertWithActions:(NSArray<NSString *> *)actionListName titleStr:(NSString *)titleStr bodyStr:(NSString *)bodyStr clickBlock:(ONE_PARAM_BLOCK)clickBlock{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:((titleStr.length > 0) ? (titleStr) : nil) message:bodyStr preferredStyle:UIAlertControllerStyleAlert];
    
    for (NSInteger pos = 0; pos < actionListName.count; pos++) {
        NSString *actionName = [actionListName objectAtIndex:pos];
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            for (NSInteger pos = 0; pos < actionListName.count; pos++) {
                NSString *actionName = [actionListName objectAtIndex:pos];
                if ([actionName isEqualToString:action.title]) {
                    if (nil != clickBlock) {
                        clickBlock(@(pos));
                    }
                }
            }
        }];
        [alertCtrl addAction:action];
    }
    [self presentViewController:alertCtrl animated:YES completion:nil];
    return alertCtrl;
}


- (void)dealloc{
    NSLog(@"控制界面释放：%@", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _isAppear = NO;
}

/**
 清除工作流

 @param flowList 工作流名称集合
 */
- (void)clearFlow:(NSArray *)flowList{
    NSArray *curCtrlList = self.navCtrl.viewControllers;
    NSMutableArray *willDeleteCtrl = [[NSMutableArray alloc] init];
    for (NSString *flowName in flowList) {
        for(UIViewController *ctrl in curCtrlList){
            if ([ctrl isKindOfClass:[YCSysCtrl class]]) {
                YCSysCtrl *tempCtrl = (YCSysCtrl *)ctrl;
                if ([flowName isEqualToString: tempCtrl.flowName]) {
                    [willDeleteCtrl addObject:tempCtrl];
                    if (self.isAppear) {
                        [self.navCtrl popViewControllerAnimated:NO];
                    }
                }
            }
        }
    }
    for (UIViewController *tempCtrl in willDeleteCtrl) {
        if (self.isAppear) {
            [self.navCtrl popViewControllerAnimated:NO];
        }
        [tempCtrl removeFromParentViewController];
    }
    [[curCtrlList mutableCopy] removeObjectsInArray:willDeleteCtrl];
}

- (void)popToRootCtrl{
    [self.navCtrl popToRootViewControllerAnimated:YES];
}
@end
