//
//  UIView+Expand.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/9.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "UIView+Expand.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#define UIView_key_tapBlock       "UIView.tapBlock"
#define UITapGesture_key_tapBlock   @"UITapGesture_key_tapBlock"
@implementation UIView(Expand)

- (void)addTapGesterTouchMethod:(void (^)(id aparam))touchBlock{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMehod)];
    [self addGestureRecognizer:tapGes];
    objc_setAssociatedObject(self, UIView_key_tapBlock, touchBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)clickMehod{
    void (^block)(UIView *)  = objc_getAssociatedObject(self, UIView_key_tapBlock);
    
    if (block)
    {
        block(self);
    }
}
@end
