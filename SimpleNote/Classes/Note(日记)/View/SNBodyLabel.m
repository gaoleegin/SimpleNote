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
 *  正文底部-距离-配图顶部的约束
 */
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *consMiddle;
/**
 *  配图视图
 */
@property (nonatomic, weak) IBOutlet UIView *imageView;
/**
 *  配图底部-距离-箭头视图顶部的约束
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
    self.cons.constant = 8.0; // 默认值:如果内容超出屏幕使用此约束
    CGFloat preRunTimeHeight = self.navBar.bounds.size.height + self.consTop.constant + self.consMiddle.constant + self.imageView.bounds.size.height + self.bounds.size.height + self.cons.constant +  self.arrowView.bounds.size.height;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    NSLog(@"%f<-->%f<-->%f<-->%f<-->%f<-->%f<-->%f<-->%f",preRunTimeHeight,screenHeight,self.navBar.bounds.size.height, self.consTop.constant, self.consMiddle.constant, self.imageView.bounds.size.height, self.cons.constant, self.arrowView.bounds.size.height);
    if (preRunTimeHeight < screenHeight) {
        self.cons.constant = [UIScreen mainScreen].bounds.size.height - self.consTop.constant - self.navBar.bounds.size.height - self.consMiddle.constant - self.imageView.bounds.size.height - self.bounds.size.height - self.arrowView.bounds.size.height;
        NSLog(@"\n%f", self.cons.constant);
    }
}

//通过storyboard创建的自动会调用sizeToFit
//- (void)setText:(NSString *)text {
//    [super setText:text];
//    [self sizeToFit];
//}
@end
