//
//  SNBodyLabel.m
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNBodyLabel.h"

@interface SNBodyLabel()

@property (nonatomic, weak) IBOutlet UIView *navBar;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *consTop;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *cons;

@property (nonatomic, weak) IBOutlet UIView *arrowView;


@end

@implementation SNBodyLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
        CGFloat preRunTimeHeight = self.navBar.bounds.size.height + self.consTop.constant + self.bounds.size.height + self.cons.constant +  self.arrowView.bounds.size.height;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        if (preRunTimeHeight < screenHeight) {
            self.cons.constant = [UIScreen mainScreen].bounds.size.height - self.consTop.constant - self.navBar.bounds.size.height - self.bounds.size.height - self.arrowView.bounds.size.height;
        }
}
@end
