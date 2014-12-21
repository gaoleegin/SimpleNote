//
//  SNImageContainerView.m
//  SimpleNote
//
//  Created by Jason on 14/12/21.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNImageContainerView.h"
#import "SNImageView.h"

@interface SNImageContainerView()

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *conMargin1;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *conMargin2;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *conMarginToTop;
@end

@implementation SNImageContainerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    int i = 0;
    for (SNImageView *view in self.subviews) {
        if ([view isKindOfClass:[SNImageView class]]) {
            if (view.image != nil) {
                i++;
            }
        }
        if (i == 0) {
            self.conMargin1.constant = 0;
            self.conMargin2.constant = 0;
            self.conMarginToTop.constant = 0;
        }
        if (i == 1) {
            self.conMargin2.constant = 0;
            self.conMarginToTop.constant = 30;
        }
    }
    
}

@end
