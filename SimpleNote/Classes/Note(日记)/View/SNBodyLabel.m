//
//  SNBodyLabel.m
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNBodyLabel.h"
#import "Common.h"

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
 *  正文底部-距离-配图视图顶部的约束
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
 *  箭头视图
 */
@property (nonatomic, weak) IBOutlet UIView *arrowView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *conW;

@end

@implementation SNBodyLabel

/**
 *  动态调整正文底部-距离-箭头视图顶部的约束
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (Iphone) {
        if (IphoneW320) {
            self.conW.constant = 280;
        }
        if (Iphone6) {
            self.conW.constant = 320;
        }
        if (Iphone6plus) {
            self.conW.constant = 340;
        }
    }
    else self.conW.constant = 480;
    
//    self.cons.constant = 20.0; // 默认值:如果内容超出屏幕使用此约束
//    CGFloat preRunTimeHeight = self.navBar.bounds.size.height + self.consTop.constant + self.consMiddle.constant + self.imageView.bounds.size.height + self.bounds.size.height + self.cons.constant +  self.arrowView.bounds.size.height;
//    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
////    NSLog(@"%f<--->%f",self.cons.constant,self.consMiddle.constant);
//    if (preRunTimeHeight < screenHeight) {
//        self.cons.constant = [UIScreen mainScreen].bounds.size.height - self.consTop.constant - self.navBar.bounds.size.height - self.consMiddle.constant - self.imageView.bounds.size.height - self.bounds.size.height - self.arrowView.bounds.size.height;
//    }
//    NSLog(@"%f",self.cons.constant);
}

//通过storyboard创建的自动会调用sizeToFit
//- (void)setText:(NSString *)text {
//    [super setText:text];
//    [self sizeToFit];
//}
@end
