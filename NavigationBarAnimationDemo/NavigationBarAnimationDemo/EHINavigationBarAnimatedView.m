//
//  EHINavigationBarAnimatedView.m
//  NavigationBarAnimationDemo
//
//  Created by yogurts on 2018/9/18.
//  Copyright © 2018年 yogurts. All rights reserved.
//

#import "EHINavigationBarAnimatedView.h"

#define ScreenHeight         [UIScreen mainScreen].bounds.size.height

#define iPhoneX              (ScreenHeight == 812.0f || ScreenHeight == 896.0f)

#define AdaptNaviHeight      (iPhoneX ? 24 : 0)

#define AdaptTabHeight       (iPhoneX ? 34 : 0)

#define NAVIHEIGHT           (iPhoneX ? 88 : 64)

#define TABBARHEIGHT         (iPhoneX ? 83 : 49)


@interface EHINavigationBarAnimatedView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, assign) CGFloat rightDistance;

@property (nonatomic, assign) CGFloat leftDistance;

@end


@implementation EHINavigationBarAnimatedView

#pragma mark - initialization

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title rightButtonImage:(UIImage *)rightButtonImage {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.text = title;
        [self.rightButton setImage:rightButtonImage forState:UIControlStateNormal];
        [self setupSubviews];
        _rightDistance = self.bounds.size.width - CGRectGetMinX(self.rightButton.frame);
        _leftDistance = CGRectGetMaxX(self.backButton.frame);
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setupSubviews];
//    }
//    return self;
//}

- (void)setupSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.backButton];
    [self addSubview:self.rightButton];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake((self.bounds.size.width - self.titleLabel.bounds.size.width) / 2, (self.bounds.size.height - self.titleLabel.bounds.size.height) / 2, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height);
    self.backButton.frame = CGRectMake(20, 2, 40, 40);
    self.rightButton.frame = CGRectMake(self.bounds.size.width - 60, 2, 40, 40);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark - methods

- (void)navBarViewAnimatedWithTranslationY:(CGFloat)translationY {
    CGFloat rightDistance = self.rightDistance * translationY / 24;
    CGFloat leftDistance = self.leftDistance * translationY / 24;
    CGFloat alpha = 1 - translationY / 44 * 1.5;
    self.alpha = alpha;
    self.rightButton.transform = CGAffineTransformMakeTranslation(rightDistance, 0);
    self.backButton.transform = CGAffineTransformMakeTranslation(-leftDistance, 0);
}

- (void)resetNavBarViewTransform {
    // TODO: implement
    self.rightButton.transform = CGAffineTransformIdentity;
    self.backButton.transform = CGAffineTransformIdentity;
}

#pragma mark - properties

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"首页";
        _titleLabel.font = [UIFont systemFontOfSize:17.f weight:UIFontWeightSemibold];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentNatural;
    }
    return _titleLabel;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"step2NavShareView"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _rightButton;
}


@end
