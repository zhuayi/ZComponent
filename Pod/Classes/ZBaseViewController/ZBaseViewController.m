//
//  BaseViewViewController.m
//  BaiduLibrary
//
//  Created by zhuayi on 14/10/20.
//  Copyright (c) 2014年 zhuayi inc. All rights reserved.
//

#import "ZBaseViewController.h"

@implementation ZBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /**
         *  设置 YES, 不监听网络状态
         */
        if (!self.isNotMontorNetWork)
        {
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
    
    if(IOS8) {
        
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

- (void)setBackImage:(UIImage *)backImage {
    
    _backImage = backImage;
    self.leftButton.image = backImage;
    self.leftButton.title = @"";
}
/**
 *  左侧按钮
 *
 *  @return
 */
- (ZBaseBarButtonItem *)leftButton {
    if (_leftButton == nil) {
        ZBaseBarButtonItem *leftBarButton = [[ZBaseBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(leftButtonAction)];
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
        _rightButton = leftBarButton;
    }
    return _rightButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    if (_isCustomNavigation) {
        
        [self.view bringSubviewToFront:_navigationBar];
        
        self.navigationBarItem.leftBarButtonItem = _leftButton;
        self.navigationBarItem.rightBarButtonItem = _rightButton;
        
    } else {
        
        self.navigationItem.leftBarButtonItem = _leftButton;
        self.navigationItem.rightBarButtonItem = _rightButton;
    }
}

- (void)viewWillDisappear: (BOOL)animated {
    [super viewWillDisappear: animated];
    if (![[self.navigationController viewControllers] containsObject: self]) {
        // the view has been removed from the navigation stack, back is probably the cause
        // this will be slow with a large stack however.
    }
    
    if (self.isCustomNavigation) {
        
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

// 是否是root控制器
- (BOOL)isRootViewController {
    return (self == self.navigationController.viewControllers.firstObject);
}

#pragma mark
#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self isRootViewController]) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
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

- (void) netWorkAvailable {
    //    NSLog(@"netWorkAvailable");
}


#pragma mark 自定义导航栏

- (void)setIsNavigationTransparent:(BOOL)isNavigationTransparent {
    _isNavigationTransparent = isNavigationTransparent;
    if (isNavigationTransparent) {
        
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBarBg"] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.shadowImage = [UIImage imageNamed:@"navigationBarBg"];
    }
}

- (void)setIsCustomNavigation:(BOOL)isCustomNavigation {
    _isCustomNavigation = isCustomNavigation;
    if (isCustomNavigation) {
        
        [self.navigationBar pushNavigationItem:self.navigationBarItem animated:YES];
        [self.view addSubview:self.navigationBar];
    }
    
}

- (UINavigationBar *)navigationBar {
    
    if (_navigationBar == nil) {
        
        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, total_topView_height)];
        _navigationBar.titleTextAttributes = self.navigationController.navigationBar.titleTextAttributes;
    }
    return _navigationBar;
}

- (UINavigationItem *)navigationBarItem {
    
    if (_navigationBarItem == nil) {
        _navigationBarItem = [[UINavigationItem alloc] initWithTitle:self.title];
    }
    return _navigationBarItem;
}


- (void)dealloc {
    //NSLog(@"dealloc :%@",[self class]);
}
@end
