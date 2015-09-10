//
//  BaseViewController.h
//  BaiduLibrary
//
//  Created by zhuayi on 14/10/20.
//  Copyright (c) 2014年 zhuayi inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMacro.h"
#import "ZBaseBarButtonItem.h"

@interface ZBaseViewController : UIViewController<UIGestureRecognizerDelegate>


/**
 *  左按钮
 */
@property (nonatomic, strong) ZBaseBarButtonItem *leftButton;

/**
 *  右按钮
 */
@property (nonatomic, strong) ZBaseBarButtonItem *rightButton;

//@property (nonatomic, strong) UIButton *leftButton;

/**
 *  右按钮
 */
//@property (nonatomic, strong) UIButton *rightButton;

/**
 *  是否不监听网络
 */
@property (nonatomic, assign) BOOL isNotMontorNetWork;

/**
 *  左侧按钮事件
 */
- (void)leftButtonAction;

/**
 *  右按钮事件
 */
- (void)rightButtonAction;

// 网络不可用时
- (void) netWorkUnavailable;

// 网络可用时
- (void) netWorkAvailable;

@end
