//
//  PlaceholderTextView.h
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//
//  自定义TextView,可根据内容来 是否显示 Placeholder
//  可自定义Placeholder的文字颜色、大小


#import <UIKit/UIKit.h>


@interface SCPlaceholderTextView : UITextView

@property(copy,nonatomic) NSString *placeholder;
@property(strong,nonatomic) UIColor *placeholderColor;
@property(strong,nonatomic) UIFont *placeholderFont;
@end

