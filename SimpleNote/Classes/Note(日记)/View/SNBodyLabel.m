//
//  SNBodyLabel.m
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNBodyLabel.h"

@interface SNBodyLabel()
/**
 *  导航栏
 */
@property (nonatomic, weak) IBOutlet UIView *navBar;
/**
 *  导航栏底部-距离-正文顶部的约束
 */
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *consTop;
/**
 *  正文底部-距离-箭头视图顶部的约束
 */
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *cons;
/**
 *  包含左右箭头的视图
 */
@property (nonatomic, weak) IBOutlet UIView *arrowView;


@end

@implementation SNBodyLabel

/**
 *  动态调整自己底部-距离-箭头视图顶部的约束
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    self.cons.constant = 41.0;
    CGFloat preRunTimeHeight = self.navBar.bounds.size.height + self.consTop.constant + self.bounds.size.height + self.cons.constant +  self.arrowView.bounds.size.height;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (preRunTimeHeight < screenHeight) {
        self.cons.constant = [UIScreen mainScreen].bounds.size.height - self.consTop.constant - self.navBar.bounds.size.height - self.bounds.size.height - self.arrowView.bounds.size.height;
    }
    NSLog(@"%f", self.cons.constant);
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self sizeToFit];
}
@end
