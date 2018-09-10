//
//  UINavigationController+NavigationBarHiddenAnimation.m
//  NavigationBarAnimationDemo
//
//  Created by yogurts on 2018/8/30.
//  Copyright © 2018年 yogurts. All rights reserved.
//

#import "UINavigationController+NavigationBarHiddenAnimation.h"

@implementation UINavigationController (NavigationBarHiddenAnimation)


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
    CGFloat rightDistance = self.navigationBar.frame.size.width - CGRectGetMinX(rightButtonBarView.frame);
    CGFloat leftDistance = CGRectGetMaxX(leftButtonBarView.frame);

    rightButtonBarView.transform = CGAffineTransformTranslate(rightButtonBarView.transform, rightDistance, 0);
    leftButtonBarView.transform = CGAffineTransformTranslate(leftButtonBarView.transform, -leftDistance, 0);
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

@end
