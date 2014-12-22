//
//  UIView+tools.h
//  03-应用管理(掌握)
//
//  Created by Meniny on 14/11/1.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/**
 *  快速加载xib，返回xib中的第一个视图
 *  @param  fileName  xib文件名
 **/
+ (instancetype)viewWithXib:(NSString *)fileName;

/**
 *  在当前视图居中展示一个提示框，然后消失
 *  @param  content  提示框需展示的文本
 **/
- (void)showSheetWithContent:(NSString *)content;

/**
 *  在当前视图居中展示一个提示框，然后消失
 *  @param  content  提示框需展示的文本
 *  @param  coorY  Y轴上的坐标值 0~2
 **/
- (void)showSheetWithContent:(NSString *)content
                      coorY:(CGFloat)coorY;


/**
 *  在当前视图居中展示一个提示框，然后消失
 *  @param  content  提示框需展示的文本
 *  @param  fontSize  内容的字体大小
 *  @param  fontColor  内容的字体颜色
 *  @param  backgroundColor  内容的背景颜色
 **/
- (void)showSheetWithContent:(NSString *)content
                   fontSize:(NSInteger)fontSize
                  fontColor:(UIColor *)fontColor
            backgroundColor:(UIColor *)backgroundColor;

/**
 *  在当前视图居中展示一个提示框，然后消失
 *  @param  content  提示框需展示的文本
 *  @param  fontSize  内容的字体大小
 *  @param  fontColor  内容的字体颜色
 *  @param  backgroundColor  内容的背景颜色
 *  @param  Y轴上的坐标值 0~2
 **/
- (void)showSheetWithContent:(NSString *)content
                   fontSize:(NSInteger)fontSize
                  fontColor:(UIColor *)fontColor
            backgroundColor:(UIColor *)backgroundColor
                      coorY:(CGFloat)coorY;

/**
 *  抓取当前view，返回一张图片
 **/
- (UIImage *)captureImage;


/**
 *  快速返回一个自定义的tabBar条
 */
+ (instancetype)tabBar;


/**
 *  在屏幕上添加一块阴影蒙版
 */
+ (void)showCover;

/**
 *  将屏幕上的阴影蒙版删除
 */
+ (void)dismissCover;




@end
