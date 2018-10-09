//
//  YCTitleView.h
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/9.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCHeaderFile.h"
NS_ASSUME_NONNULL_BEGIN

@interface YCTitleView : UIView
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong, readonly) UIImageView *backImageView;
@property (nonatomic, strong, readonly) UIView *rightView;
+(instancetype)createTitleView:(UIView *)superView clickBackBlock:(ONE_PARAM_BLOCK)clickBackBlock clickRightViewBlock:(ONE_PARAM_BLOCK)clickRightViewBlock;
@end

NS_ASSUME_NONNULL_END
