//
//  YCCircleBeadBtn.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/9.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCCircleBeadBtn.h"
#import "PureLayout.h"
#import "ReactiveObjC.h"
#import "UIColor+YCColor.h"
@interface YCCircleBeadBtn()
@property (nonatomic, strong) UIColor *disableBgColor;
@property (nonatomic, strong) UIColor *enableBgColor;
@end
@implementation YCCircleBeadBtn
- (instancetype)initWithBgColor:(UIColor *)disableBgColor enableBgColor:(UIColor *)enableBgColor{
    if (self = [super init]) {
        UIColor *disBgColor = [UIColor colorWithRed:122.f/255 green:225.f/255 blue:227.f/255 alpha:0.5];
        UIColor *bgColor = [UIColor ycGreen1Color];
        self.enableBgColor = (enableBgColor == nil) ? (bgColor) : (enableBgColor);
        self.disableBgColor = (disableBgColor == nil) ? (disBgColor) : (disableBgColor);
        [self bindEvent];
    }
    return self;
}
+(instancetype)createBtnWithAttr:(UIColor *)disableBgColor enableBgColor:(UIColor *)enableBgColor title:(NSString *)title cr:(CGFloat )cr{
    YCCircleBeadBtn *btn = [[YCCircleBeadBtn alloc] initWithBgColor:disableBgColor enableBgColor:enableBgColor];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.cornerRadius = cr;
    btn.layer.masksToBounds = YES;
    return btn;
}
- (void)bindEvent{
    @weakify(self);
    [RACObserve(self, enabled) subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            self_weak_.backgroundColor = self_weak_.enableBgColor;
        }else{
            self_weak_.backgroundColor = self_weak_.disableBgColor;
        }
    }];
}
@end
