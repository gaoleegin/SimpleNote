//
//  PlaceholderTextView.m
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import "SCPlaceholderTextView.h"

@interface SCPlaceholderTextView()<UITextViewDelegate>

@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation SCPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        [self setUp];
        self.placeholder = @"写点什么吧...";
    }
    return self;
}

- (void)setUp {
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChange:) name:UITextViewTextDidChangeNotification object:self];

    float left = 10,top = 2,hegiht = 30;
    
    self.placeholderColor = [UIColor lightGrayColor];
    UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                               , CGRectGetWidth(self.frame) - 2*left, hegiht)];
    placeholderLabel.font = self.placeholderFont ? self.placeholderFont : self.font;
    placeholderLabel.textColor = self.placeholderColor;
    [self addSubview:placeholderLabel];
    placeholderLabel.text = self.placeholder;
    
    self.placeholderLabel = placeholderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        self.placeholderLabel.hidden = YES;
    }
    else
        self.placeholderLabel.text = placeholder;
    _placeholder = placeholder;

}

- (void)didChange:(NSNotification *)noti {

    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        self.placeholderLabel.hidden = YES;
    }
    
    if (self.text.length > 0) {
        self.placeholderLabel.hidden = YES;
    }
    else{
        self.placeholderLabel.hidden = NO;
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.placeholderLabel removeFromSuperview];
}

@end

