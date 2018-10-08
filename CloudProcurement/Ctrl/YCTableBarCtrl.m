//
//  YCTableBarCtrl.m
//  ProductionCreateTest
//
//  Created by MDJ on 2018/9/25.
//  Copyright © 2018年 TsunamiLi. All rights reserved.
//

#import "YCTableBarCtrl.h"
#import "YCSysCtrl.h"
#import "YCLoginCtrl.h"
#import "YCMainCtrl.h"
#import "YCClassificationCtrl.h"
#import "YCOrderCtrl.h"
#import "UIImageView+WebCache.h"
@implementation BarBtnItemContentView

- (instancetype)init {
    if(self = [super init]){
         self.isSelected = NO;
        [self initUI];
        [self bindRac];
//        [self bindEvent];
    }
    return self;
}

- (void)initUI {
    UIView *contentView = [UIView newAutoLayoutView];
    [self addSubview:contentView];
    [contentView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    self.selectImageView = [UIImageView newAutoLayoutView];
    self.selectImageView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:self.selectImageView];
    [self.selectImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.selectImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    
    self.bottomTitleLabel = [UILabel newAutoLayoutView];
    self.bottomTitleLabel.text = @"bottomTitleLabel";
    self.bottomTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.bottomTitleLabel];
    [self.bottomTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.selectImageView];
    [self.bottomTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.bottomTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.bottomTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)bindRac {
//    __weak BarBtnItemContentView *weakSelf = self;
    @weakify(self);
    [RACObserve(self, isSelected) subscribeNext:^(id  _Nullable x) {
        if(self_weak_.imageList == nil || self_weak_.imageList.count <= 0){
            return;
        }
        if (![x boolValue]) {
            UIImage *image = [self_weak_.imageList firstObject];
            [self_weak_.selectImageView setImage:image];
        }else{
            UIImage *image = [self_weak_.imageList firstObject];
            if(self_weak_.imageList.count >= 2){
                image = [self_weak_.imageList objectAtIndex:1];
            }
            [self_weak_.selectImageView setImage:image];
        }
    }];
}
- (void)setImageList:(NSArray<UIImage *> * _Nonnull)imageList{
    _imageList = imageList;
    self.isSelected = self.isSelected;
}
@end

@interface YCTableBarCtrl ()<UITabBarControllerDelegate>
@property (nonatomic, strong) NSMutableArray *barList;
@property(nonatomic, strong) NSArray<YCSysCtrl *> *ctrlList;
@end

@implementation YCTableBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.barList = @[@[@"首页", @[@"tabbar_ic_one_normal", @"tabbar_ic_one_selected"]],
                              @[@"分类", @[@"tabbar_ic_two_normal", @"tabbar_ic_two_selected"]],
                              @[@"订单", @[@"tabbar_ic_three_normal", @"tabbar_ic_three_selected"]],
                              @[@"我的", @[@"tabbar_ic_four_normal", @"tabbar_ic_four_selected"]]].mutableCopy;
    self.ctrlList = @[[[YCMainCtrl alloc] initWithFlowName:@"YCMainCtrl"],
                      [[YCClassificationCtrl alloc] initWithFlowName:@"YCClassificationCtrl"],
                      [[YCOrderCtrl alloc] initWithFlowName:@"YCOrderCtrl"],
                      [[YCLoginCtrl alloc] initWithFlowName:@"YCLoginCtrl"]];
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (YCSysCtrl *tempCtrl in self.ctrlList) {
        [tempCtrl setNavCtrl:(UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController];
    }
}

- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    for (NSInteger pos = 0; pos < self.barList.count; pos++) {
        NSArray *tempList = [self.barList objectAtIndex:pos];
        if (nil == tempList || tempList.count <= 0) {
            continue;
        }
        NSString *tempNameStr = [tempList firstObject];
        NSArray *tempImageList = [tempList lastObject];
        YCSysCtrl *tempCtrl = [self.ctrlList objectAtIndex:pos];
        tempCtrl.title = tempNameStr;
        tempCtrl.tabBarItem.title = tempNameStr;
        [tempCtrl.tabBarItem setTitleTextAttributes:nil forState:UIControlStateSelected];
        UIImage *normalImage = YCDefImageWithName([tempImageList firstObject]);
        UIImage *selectedImage = YCDefImageWithName([tempImageList lastObject]);
        
        [tempCtrl.tabBarItem setImage:normalImage];
        [tempCtrl.tabBarItem setSelectedImage:selectedImage];
        tempCtrl.view.tag = pos;
        [tempCtrl setNavCtrl:self.navigationController];
        [self addChildViewController:tempCtrl];
    }
}
#pragma mark UITabBarControllerDelegate
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0);
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}

@end
