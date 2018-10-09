//
//  UIView+Expand.h
//  CloudProcurement
//
//  Created by TsunamiLi on 2018/10/9.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface  UIView(Expand)
- (void)addTapGesterTouchMethod:(void (^)(id aparam))touchBlock;
@end

NS_ASSUME_NONNULL_END
