//
//  SNNoteTool.h
//  SimpleNote
//
//  Created by Jason on 14/12/12.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//
//  日记数据工具类

#import <Foundation/Foundation.h>

@interface SNNoteTool : NSObject

/**
 *  存储日记
 */
+ (void)save:(NSMutableArray *)notes;


/**
 *  读取日记
 */
+ (NSMutableArray *)notes;

/**
 *  删除日记
 *
 *  @param index 日记下标
 */
+ (void)deleteNoteWithIndex:(int)index;
@end
