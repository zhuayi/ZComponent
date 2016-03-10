//
//  BaseViewViewController.m
//  BaiduLibrary
//
//  Created by zhuayi on 14/10/20.
//  Copyright (c) 2014年 zhuayi inc. All rights reserved.
//

#import "ZBaseViewController.h"

@implementation ZBaseViewController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        /**
         *  设置 YES, 不监听网络状态
         */
        if (!self.isNotMontorNetWork) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkUnavailable) name:@"netWorkUnavailable" object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkAvailable) name:@"netWorkAvailable" object:nil];
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //IOS7 UI适配
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    if (IOS8) {
        // IOS8多了一个样式UIModalPresentationOverCurrentContext，
        // IOS8中presentViewController时请将控制器的modalPresentationStyle设置为UIModalPresentationOverCurrentContext
        // 否则会出现
        // Snapshotting a view that has not been rendered results in an empty snapshot. Ensure your view has been rendered at least once before snapshotting or snapshot after screen updates.
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    }
}

/**
 *  左侧按钮
 *
 *  @return
 */
- (ZBaseBarButtonItem *)leftButton {
    if (_leftButton == nil) {
        ZBaseBarButtonItem *leftBarButton = [[ZBaseBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(leftButtonAction)];
        self.navigationItem.leftBarButtonItem = leftBarButton;
        _leftButton = leftBarButton;
    }
    
    return _leftButton;
}

/**
 *  右侧按钮
 *
 *  @return
 */
- (ZBaseBarButtonItem *)rightButton {
    if (_rightButton == nil) {
        ZBaseBarButtonItem *leftBarButton = [[ZBaseBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(rightButtonAction)];
        self.navigationItem.rightBarButtonItem = leftBarButton;
        
        _rightButton = leftBarButton;
    }
    
    return _rightButton;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (![[self.navigationController viewControllers] containsObject:self]) {
        // the view has been removed from the navigation stack, back is probably the cause
        // this will be slow with a large stack however.
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%s", __func__);
    // Dispose of any resources that can be recreated.
}

- (void)leftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonAction {
}

- (void)netWorkUnavailable {
    //NSLog(@"网络不可用");
}

- (void)netWorkAvailable {
    //    NSLog(@"netWorkAvailable");
}

- (void)dealloc {
    //NSLog(@"dealloc :%@",[self class]);
}

@end
