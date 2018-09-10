//
//  ViewController.m
//  NavigationBarAnimationDemo
//
//  Created by yogurts on 2018/8/30.
//  Copyright © 2018年 yogurts. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationController+NavigationBarHiddenAnimation.h"

#define NAVBAR_TRANSLATION_POINT 0
#define NavBarHeight 44

@interface ViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"首页";
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame));
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.delegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
    [self.navigationController.navigationBar addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    // 向上滑动的距离
    CGFloat scrollUpHeight = offsetY - NAVBAR_TRANSLATION_POINT;
    // 除数表示 -> 导航栏从完全不透明到完全透明的过渡距离
    CGFloat progress = scrollUpHeight / NavBarHeight;
    if (offsetY > NAVBAR_TRANSLATION_POINT)
    {
        if (scrollUpHeight > 44)
        {
            [self setNavigationBarTransformProgress:1];
        }
        else
        {
            [self setNavigationBarTransformProgress: progress];
        }
    }
    else
    {
        [self setNavigationBarTransformProgress:0];
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.navigationController setTranslationY:(-NavBarHeight * progress)];
    // 没有系统返回按钮，所以 hasSystemBackIndicator = NO
    // 如果这里不设置为NO，你会发现，导航栏无缘无故多出来一个返回按钮
//    [self.navigationController wr_setBarButtonItemsAlpha:(1 - progress) hasSystemBackIndicator:NO];
    [self.navigationController animation_setNavigationBarHidden:<#(BOOL)#> translationY:(-NavBarHeight * progress)];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideBottomView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self showBottomView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self showBottomView];
}

- (void)hideBottomView {
    [UIView animateWithDuration:.25f animations:^{
        self.bottomView.transform = CGAffineTransformTranslate(self.bottomView.transform, 0, self.bottomView.bounds.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showBottomView {
    [UIView animateWithDuration:.25f animations:^{
        self.bottomView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}


@end
