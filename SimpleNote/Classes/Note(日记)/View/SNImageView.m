//
//  SNImageView.m
//  SimpleNote
//
//  Created by Jason on 14/12/15.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNImageView.h"
#import "Common.h"

@interface SNImageView()

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *heightCons;

/**
 *  导航栏
 */
@property (nonatomic, weak) IBOutlet UIView *navBar;
/**
 *  导航栏底部-距离-正文顶部的约束
 */
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *consTop;
/**
 *  正文Label
 */
@property (nonatomic, weak) IBOutlet UILabel *bodyLabel;
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


@end
@implementation SNImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)layoutSubviews {
    [super layoutSubviews];
//    NSLog(@"%@", self.image);
    if (self.image) {
        if (Iphone) self.heightCons.constant = 280;
        else self.heightCons.constant = 480;
    }
    else self.heightCons.constant = 0;

    self.cons.constant = 20.0; // 默认值:如果内容超出屏幕使用此约束
    CGFloat preRunTimeHeight = self.navBar.bounds.size.height + self.consTop.constant + self.consMiddle.constant + self.imageView.bounds.size.height + self.bodyLabel.bounds.size.height + self.cons.constant +  self.arrowView.bounds.size.height;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//        NSLog(@"<--->%f",self.imageView.bounds.size.height);
    if (preRunTimeHeight < screenHeight) {
        self.cons.constant = [UIScreen mainScreen].bounds.size.height - self.consTop.constant - self.navBar.bounds.size.height - self.consMiddle.constant - self.imageView.bounds.size.height - self.bodyLabel.bounds.size.height - self.arrowView.bounds.size.height;
    }
//        NSLog(@"%f",self.cons.constant);
}

@end
