//
//  SCSaveTool.h
//  JasonLottery-练习03
//
//  Created by Jason on 14/11/12.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//
//  版本号存储工具类

#import <Foundation/Foundation.h>

@interface SCSaveTool : NSObject

+ (id)objectForKey:(NSString *)defaultName;
+ (void)setObject:(id)value forKey:(NSString *)defaultName;

@end
