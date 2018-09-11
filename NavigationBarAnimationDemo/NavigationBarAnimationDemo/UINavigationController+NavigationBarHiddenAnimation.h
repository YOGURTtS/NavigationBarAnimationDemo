//
//  UINavigationController+NavigationBarHiddenAnimation.h
//  NavigationBarAnimationDemo
//
//  Created by yogurts on 2018/8/30.
//  Copyright © 2018年 yogurts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (NavigationBarHiddenAnimation)

- (void)animation_setNavigationBarHidden:(BOOL)hidden translationY:(CGFloat)translationY;

- (void)setTranslationY:(CGFloat)translationY;
 
- (void)setNavigationBarButtonItemsAnimationWithTranslationY:(CGFloat)translationY;

- (UIView *)getRightButtonBarView;

- (UIView *)getLeftButtonBarView;

- (UILabel *)getTitleLabel;

- (void)setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

@property (nonatomic, assign) CGFloat rightDistance;
@property (nonatomic, assign) CGFloat leftDistance;


@end
