//
//  YCTitleView.m
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/9.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCTitleView.h"
#import "PureLayout.h"
@implementation YCTitleView

+(instancetype)createTitleView:(UIView *)superView clickBackBlock:(ONE_PARAM_BLOCK)clickBackBlock clickRightViewBlock:(ONE_PARAM_BLOCK)clickRightViewBlock{
    if (superView == nil) {
        return nil;
    }
    YCTitleView *titleView = [YCTitleView newAutoLayoutView];
    [superView addSubview:titleView];
    [titleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [titleView autoSetDimension:ALDimensionHeight toSize:40];
    return titleView;
}

- (void)initUI{
    UIImageView *backImageView = [UIImageView newAutoLayoutView];
    _backImageView = backImageView;
    [backImageView setImage:YCDefImageWithName(@"")];
}
@end
