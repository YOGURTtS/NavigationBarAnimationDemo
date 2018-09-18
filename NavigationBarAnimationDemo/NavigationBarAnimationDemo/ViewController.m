//
//  ViewController.m
//  NavigationBarAnimationDemo
//
//  Created by yogurts on 2018/8/30.
//  Copyright © 2018年 yogurts. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationController+NavigationBarHiddenAnimation.h"
#import "EHINavigationBarAnimatedView.h"

#define NAVBAR_TRANSLATION_POINT -64
#define NavBarHeight 44

@interface ViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, assign) CGFloat lastContentOffset;

@property (nonatomic, assign) CGFloat rightDistance;
@property (nonatomic, assign) CGFloat leftDistance;

@property (nonatomic, strong) EHINavigationBarAnimatedView *navView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"首页";
    _navView = [[EHINavigationBarAnimatedView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44) title:@"首页" rightButtonImage:nil];
    [self.view addSubview:_navView];
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(_navView.frame), self.view.bounds.size.width, self.view.bounds.size.height);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.delegate = self;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
//    [self.navigationController.navigationBar addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    UIView *rightButtonBarView = [self.navigationController getRightButtonBarView];
//    UIView *leftButtonBarView = [self.navigationController getLeftButtonBarView];
//    self.rightDistance = self.navigationController.navigationBar.frame.size.width - CGRectGetMinX(rightButtonBarView.frame);
//    self.leftDistance = CGRectGetMaxX(leftButtonBarView.frame);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    CGRect frame = [change[@"frame"] CGRectValue];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(frame));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f", scrollView.contentOffset.y);
//    if (scrollView.contentOffset.y > 0.f) {
////        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        [self.navigationController animation_setNavigationBarHidden:YES translationY:0];
//    }
//    if (scrollView.contentOffset.y <= 0.f) {
////        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        [self.navigationController animation_setNavigationBarHidden:NO translationY:0];
//    }
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollView.contentOffset.y = %lf", scrollView.contentOffset.y);
//    CGFloat offsetY = scrollView.contentOffset.y;
//
////    if (offsetY >= -64) {
//        if (self.lastContentOffset > scrollView.contentOffset.y) {
//            // 向下滚动
//            if (offsetY + 64 < 0) {
//                UIView *rightButtonBarView = [self.navigationController getRightButtonBarView];
//                UIView *leftButtonBarView = [self.navigationController getLeftButtonBarView];
//                rightButtonBarView.transform = CGAffineTransformIdentity;
//                leftButtonBarView.transform = CGAffineTransformIdentity;
//            } else {
//                NSLog(@"alpha = %lf", 1 - (offsetY + 64) / 14);
//                [self setNavigationBarButtonItemsAnimationWithTranslationY:(offsetY + 64)];
//                [self.navigationController setBarButtonItemsAlpha:1 - (offsetY + 64) / 14 hasSystemBackIndicator:NO];
//            }
//        } else if (self.lastContentOffset < scrollView.contentOffset.y) {
//            // 向上滚动
//            if (offsetY + 64 < 0) {
//                UIView *rightButtonBarView = [self.navigationController getRightButtonBarView];
//                UIView *leftButtonBarView = [self.navigationController getLeftButtonBarView];
//                rightButtonBarView.transform = CGAffineTransformIdentity;
//                leftButtonBarView.transform = CGAffineTransformIdentity;
//            } else {
//                NSLog(@"alpha = %lf", 1 - (offsetY + 64) / 14);
//                [self setNavigationBarButtonItemsAnimationWithTranslationY:(offsetY + 64)];
//                [self.navigationController setBarButtonItemsAlpha:1 - (offsetY + 64) / 14 hasSystemBackIndicator:NO];
//            }
//        }
//        [self.navigationController setTranslationY:-(offsetY + 64)];
////    }
//    self.lastContentOffset = scrollView.contentOffset.y;
//}

//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    if (self.lastContentOffset > scrollView.contentOffset.y) {
//        // 向下滚动
//
//    } else if (self.lastContentOffset < scrollView.contentOffset.y) {
//        // 向上滚动
//
//    }
//}

//- (void)setNavigationBarTransformProgress:(CGFloat)progress {
//    NSLog(@"NavBarHeight * progress = %lf", NavBarHeight * progress);
//    [self.navigationController setTranslationY:(-NavBarHeight * progress)];
//    // 没有系统返回按钮，所以 hasSystemBackIndicator = NO
//    // 如果这里不设置为NO，你会发现，导航栏无缘无故多出来一个返回按钮
////    [self.navigationController wr_setBarButtonItemsAlpha:(1 - progress) hasSystemBackIndicator:NO];
//
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self hideBottomView];
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (self.lastContentOffset > scrollView.contentOffset.y) {
//        // 向下滚动
//        UIView *rightButtonBarView = [self.navigationController getRightButtonBarView];
//        UIView *leftButtonBarView = [self.navigationController getLeftButtonBarView];
//        rightButtonBarView.transform = CGAffineTransformIdentity;
//        leftButtonBarView.transform = CGAffineTransformIdentity;
//    } else if (self.lastContentOffset < scrollView.contentOffset.y) {
//        // 向上滚动
//
//    }
//    [self showBottomView];
//}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    if (self.lastContentOffset > scrollView.contentOffset.y) {
//        // 向下滚动
//        UIView *rightButtonBarView = [self.navigationController getRightButtonBarView];
//        UIView *leftButtonBarView = [self.navigationController getLeftButtonBarView];
//        rightButtonBarView.transform = CGAffineTransformIdentity;
//        leftButtonBarView.transform = CGAffineTransformIdentity;
//    } else if (self.lastContentOffset < scrollView.contentOffset.y) {
//        // 向上滚动
//
//    }
//    [self showBottomView];
//}
//
//- (void)hideBottomView {
//    [UIView animateWithDuration:.25f animations:^{
//        self.bottomView.transform = CGAffineTransformTranslate(self.bottomView.transform, 0, self.bottomView.bounds.size.height);
//    } completion:^(BOOL finished) {
//
//    }];
//}
//
//- (void)showBottomView {
//    [UIView animateWithDuration:.25f animations:^{
//        self.bottomView.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//
//    }];
//}
//
//- (void)setNavigationBarButtonItemsAnimationWithTranslationY:(CGFloat)translationY {
//    UIView *rightButtonBarView = [self.navigationController getRightButtonBarView];
//    UIView *leftButtonBarView = [self.navigationController getLeftButtonBarView];
//    UIView *titleView = [self.navigationController getTitleLabel];
////    if (CGRectGetMaxX(leftButtonBarView.frame) - self.leftDistance > 2) {
////        return;
////    }
//
//    CGFloat rightDistance = self.rightDistance * translationY / 14;
//    CGFloat leftDistance = self.leftDistance * translationY / 14;
//
//    NSLog(@"rightDistance = %lf , leftDistance = %lf", rightDistance, leftDistance);
//
//    //    rightButtonBarView.transform = CGAffineTransformTranslate(rightButtonBarView.transform, rightDistance, 0);
//    rightButtonBarView.transform = CGAffineTransformMakeTranslation(rightDistance, translationY);
//    //    leftButtonBarView.transform = CGAffineTransformTranslate(leftButtonBarView.transform, -leftDistance, 0);
//    leftButtonBarView.transform = CGAffineTransformMakeTranslation(-leftDistance, translationY);
//    titleView.transform = CGAffineTransformMakeTranslation(0, translationY);
//    NSLog(@"titleView = %@", titleView);
//}


@end
