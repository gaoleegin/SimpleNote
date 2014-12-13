//
//  SNImageTool.h
//  SimpleNote
//
//  Created by Jason on 14/12/13.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNImageTool : NSObject

/**
 *  存储日记图片
 */
+ (void)save:(UIImage *)image imageName:(NSString *)imageName;


/**
 *  读取日记图片路径
 */
+ (NSString *)imagePath:(NSString *)imageName;

@end
