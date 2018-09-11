//
//  UINavigationController+NavigationBarHiddenAnimation.m
//  NavigationBarAnimationDemo
//
//  Created by yogurts on 2018/8/30.
//  Copyright © 2018年 yogurts. All rights reserved.
//


#import "UINavigationController+NavigationBarHiddenAnimation.h"
#import <objc/runtime.h>


@implementation UINavigationController (NavigationBarHiddenAnimation)

static NSString *rightDistanceKey = @"rightDistanceKey";
static NSString *leftDistanceKey = @"leftDistanceKey";

- (void)setRightDistance:(CGFloat)rightDistance {
    objc_setAssociatedObject(self, &rightDistanceKey, @(rightDistance), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)rightDistance {
    return [objc_getAssociatedObject(self, &rightDistanceKey) floatValue];
}

- (void)setLeftDistance:(CGFloat)leftDistance {
    objc_setAssociatedObject(self, &leftDistanceKey, @(leftDistance), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)leftDistance {
    return [objc_getAssociatedObject(self, &leftDistanceKey) floatValue];
}

//+ (void)initialize
//{
//    if (self == [UINavigationController class]) {
//        UIView *rightButtonBarView = [self getRightButtonBarView];
//        UIView *leftButtonBarView = [self getLeftButtonBarView];
//        self.rightDistance = self.navigationBar.frame.size.width - CGRectGetMinX(rightButtonBarView.frame);
//        self.leftDistance = CGRectGetMaxX(leftButtonBarView.frame);
//    }
//}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        UIView *rightButtonBarView = [self getRightButtonBarView];
//        UIView *leftButtonBarView = [self getLeftButtonBarView];
//        self.rightDistance = self.navigationBar.frame.size.width - CGRectGetMinX(rightButtonBarView.frame);
//        self.leftDistance = CGRectGetMaxX(leftButtonBarView.frame);
//    }
//    return self;
//}

- (void)animation_setNavigationBarHidden:(BOOL)hidden translationY:(CGFloat)translationY {
    UIView *rightButtonBarView = [self getRightButtonBarView];
    UIView *leftButtonBarView = [self getLeftButtonBarView];
    UILabel *titleLabel = [self getTitleLabel];
    CGFloat rightDistance = self.navigationBar.frame.size.width - CGRectGetMinX(rightButtonBarView.frame);
    CGFloat leftDistance = CGRectGetMaxX(leftButtonBarView.frame);
    if (hidden) {
        if (self.navigationBar.isHidden == YES) {
            return;
        }
//        [self setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:1.25f animations:^{
            rightButtonBarView.transform = CGAffineTransformTranslate(rightButtonBarView.transform, rightDistance, 0);
            leftButtonBarView.transform = CGAffineTransformTranslate(leftButtonBarView.transform, -leftDistance, 0);
            titleLabel.alpha = .0f;
            self.navigationBar.tintColor = [[UIColor blackColor] colorWithAlphaComponent:.0f];
        } completion:^(BOOL finished) {
            self.navigationBar.hidden = YES;
        }];
    } else {
        if (self.navigationBar.isHidden == NO) {
            return;
        }
        [self setNavigationBarHidden:NO animated:YES];
        [UIView animateWithDuration:1.25f animations:^{
            rightButtonBarView.transform = CGAffineTransformIdentity;
            leftButtonBarView.transform = CGAffineTransformIdentity;
            titleLabel.alpha = 1.f;
            self.navigationBar.tintColor = [[UIColor blackColor] colorWithAlphaComponent:1.f];
        } completion:^(BOOL finished) {
            self.navigationBar.hidden = NO;
        }];
    }
}

- (void)setNavigationBarButtonItemsAnimationWithTranslationY:(CGFloat)translationY {
    UIView *rightButtonBarView = [self getRightButtonBarView];
    UIView *leftButtonBarView = [self getLeftButtonBarView];
    
    CGFloat rightDistance = self.rightDistance * translationY / 14;
    CGFloat leftDistance = self.leftDistance * translationY / 14;
    NSLog(@"rightDistance = %lf , leftDistance = %lf", self.rightDistance, self.leftDistance);
    
//    rightButtonBarView.transform = CGAffineTransformTranslate(rightButtonBarView.transform, rightDistance, 0);
    rightButtonBarView.transform = CGAffineTransformMakeTranslation(rightDistance, translationY);
//    leftButtonBarView.transform = CGAffineTransformTranslate(leftButtonBarView.transform, -leftDistance, 0);
    leftButtonBarView.transform = CGAffineTransformMakeTranslation(-leftDistance, translationY);
}

- (UIView *)getRightButtonBarView {
    if (@available(iOS 11.0, *)) {
        for (UIView *view in self.navigationBar.subviews) {
            for (UIView *subView in view.subviews) {
                if ([NSStringFromClass(subView.class) isEqualToString:@"_UIButtonBarStackView"] && CGRectGetMidX(subView.frame) > CGRectGetMidX(self.navigationBar.frame)) {
                    return subView;
                }
            }
        }
    } else {
        for (int i = 0; i < self.navigationBar.subviews.count; i++) {
            UIView *t_view = self.navigationBar.subviews[i];
            if (i == self.navigationBar.subviews.count - 1) {
                return t_view;
            }
        }
    }
    return nil;
}

- (UIView *)getLeftButtonBarView {
    if (@available(iOS 11.0, *)) {
        for (UIView *view in self.navigationBar.subviews) {
            for (UIView *subView in view.subviews) {
                if ([NSStringFromClass(subView.class) isEqualToString:@"_UIButtonBarStackView"] && CGRectGetMidX(subView.frame) < CGRectGetMidX(self.navigationBar.frame)) {
                    return subView;
                }
            }
        }
    } else {
        for (int i = 0; i < self.navigationBar.subviews.count; i++) {
            UIView *t_view = self.navigationBar.subviews[i];
            if (i == 0) {
                return t_view;
            }
        }
    }
    return nil;
}

- (UILabel *)getTitleLabel {
    if (@available(iOS 11.0, *)) {
        for (UIView *view in self.navigationBar.subviews) {
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:[UILabel class]]) {
                    return (UILabel *)subView;
                }
            }
        }
    } else {
        for (int i = 0; i < self.navigationBar.subviews.count; i++) {
            UIView *t_view = self.navigationBar.subviews[i];
            if ([t_view isKindOfClass:[UILabel class]]) {
                return (UILabel *)t_view;
            }
        }
    }
    return nil;
}

- (void)setTranslationY:(CGFloat)translationY {
    self.navigationBar.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator {
    for (UIView *view in self.navigationBar.subviews) {
        if (hasSystemBackIndicator == YES)
        {   // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil) {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil) {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        }
        else {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil) {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil) {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

@end
