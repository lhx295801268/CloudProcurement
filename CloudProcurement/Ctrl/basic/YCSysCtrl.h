//
//  YCSysCtrl.h
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/25.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"
#import "PureLayout.h"
#import "YCHeaderFile.h"
@interface YCSysCtrl : UIViewController
@property(nonatomic, copy, readonly) NSString *flowName;
@property (nonatomic, assign, readonly) BOOL isAppear;
@property(nonatomic, assign) BOOL navationbarHidden;
@property (nonatomic, copy) NSString *titleStr;
-(instancetype)initWithFlowName:(NSString *)flowName;
-(void)setFlowName:(NSString *)flowName;
- (void)setNavCtrl:(UINavigationController *)navCtrl;
#pragma mark 界面跳转
/**
 跳转到目标界面
 */
- (void)gotoNextCtrl:(YCSysCtrl *)desCtrl;

/**
 跳转目标界面之后清理工作流
 @param desCtrl 目标界面控制器
 @param flowList 清理的工作流数组
 */
- (void)gotoNextCtrlAndClearFlows:(YCSysCtrl *)desCtrl flowList:(NSArray<NSString *>*)flowList;

/**
 pop掉对应工作流的视图界面控制器

 @param flowName 工作流
 */
-(void)popCtrl4FlowName:(NSString *)flowName;

- (void)popToRootCtrl;
#pragma mark 警告框
- (UIAlertController *)showAlertView:(NSString *)titleString bodyStr:(NSString *)bodyStr clickBlock:(ONE_PARAM_BLOCK)clickBlock;

-(UIAlertController *)showAlertWithActions:(NSArray<NSString *> *)actionListName titleStr:(NSString *)titleStr bodyStr:(NSString *)bodyStr clickBlock:(ONE_PARAM_BLOCK)clickBlock;

- (void)onBack;
@end
