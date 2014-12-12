//
//  HWPopMenu.h
//  3期微博
//
//  Created by apple on 14/12/10.
//  Copyright (c) 2014年 heima. All rights reserved.
//
//  依赖类 UIView+Extension.h

#import <UIKit/UIKit.h>

@interface SCPopMenu : NSObject
/**
 *  弹出一个菜单
 *
 *  @param view    菜单的箭头指向谁
 *  @param content 菜单里面的内容
 *  @param dismiss 菜单销毁的时候想做的事情
 */
+ (void)popFromView:(UIView *)view content:(UIView *)content dismiss:(void(^)())dismiss;

/**
 *  弹出一个菜单
 *
 *  @param view    参照系
 *  @param rect    菜单的箭头指向的矩形框
 *  @param content 菜单里面的内容
 *  @param dismiss 菜单销毁的时候想做的事情
 */
+ (void)popFromRect:(CGRect)rect inView:(UIView *)view content:(UIView *)content dismiss:(void(^)())dismiss;


/**
 *  弹出一个菜单
 *
 *  @param view    菜单的箭头指向谁
 *  @param contentVc 菜单里面的内容
 *  @param dismiss 菜单销毁的时候想做的事情
 */
+ (void)popFromView:(UIView *)view contentVc:(UIViewController *)contentVc dismiss:(void(^)())dismiss;

/**
 *  弹出一个菜单
 *
 *  @param view    参照系
 *  @param rect    菜单的箭头指向的矩形框
 *  @param contentVc 菜单里面的内容
 *  @param dismiss 菜单销毁的时候想做的事情
 */
+ (void)popFromRect:(CGRect)rect inView:(UIView *)view contentVc:(UIViewController *)contentVc dismiss:(void(^)())dismiss;
@end
