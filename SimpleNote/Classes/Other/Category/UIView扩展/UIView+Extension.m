//
//  UIView+tools.m
//  03-应用管理(掌握)
//
//  Created by Meniny on 14/11/1.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

+ (instancetype)viewWithXib:(NSString *)fileName
{
    return [[NSBundle mainBundle] loadNibNamed:fileName owner:nil options:nil][0];
}


- (void)setSheetWithContent:(NSString *)content
                   fontSize:(NSInteger)fontSize
                  fontColor:(UIColor *)fontColor
            backgroundColor:(UIColor *)backgroundColor

{
    UILabel *label = [[UILabel alloc] init];
    label.text = content;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = fontColor;
    label.backgroundColor = backgroundColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, 150, 25);
    label.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    label.alpha = 0.0;
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    [self addSubview:label];
    
    [UIView animateWithDuration:1.0 animations:^{
        label.alpha = 0.7;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            label.alpha = 0.0;
        }completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

- (void)setSheetWithContent:(NSString *)content
                   fontSize:(NSInteger)fontSize
                  fontColor:(UIColor *)fontColor
            backgroundColor:(UIColor *)backgroundColor
                      coorY:(CGFloat)coorY {
    UILabel *label = [[UILabel alloc] init];
    label.text = content;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = fontColor;
    label.backgroundColor = backgroundColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, 150, 25);
    label.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * coorY);
    label.alpha = 0.0;
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    [self addSubview:label];
    
    [UIView animateWithDuration:1.0 animations:^{
        label.alpha = 0.7;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            label.alpha = 0.0;
        }completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}



- (void)setSheetWithContent:(NSString *)content
{
    [self setSheetWithContent:content fontSize:12 fontColor:[UIColor whiteColor] backgroundColor:[UIColor blackColor]];
}

- (void)setSheetWithContent:(NSString *)content coorY:(CGFloat)coorY
{
    [self setSheetWithContent:content fontSize:12 fontColor:[UIColor whiteColor] backgroundColor:[UIColor blackColor] coorY:coorY];
}



- (UIImage *)captureImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (instancetype)tabBar {
    return [[self alloc] init];
}


+ (void)showCover {
    id cover = [[self alloc] init];
    [cover setFrame:[UIScreen mainScreen].bounds];
    [cover setBackgroundColor:[UIColor blackColor]];
    [cover setAlpha:0.33];
    [cover setTag:33];
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
}

+ (void)dismissCover {
    
    for (UIView *cover in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([[NSString stringWithFormat:@"%.2f", cover.alpha] isEqualToString:@"0.33"] && cover.tag == 33) {
            [cover removeFromSuperview];
        }
    }
}

@end
