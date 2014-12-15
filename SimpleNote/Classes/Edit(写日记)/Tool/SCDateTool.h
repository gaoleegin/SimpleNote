//
//  SCDateTool.h
//  SimpleNote
//
//  Created by Jason on 14/12/15.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCDateTool : NSObject

/**
 *  读取英文月份 January
 */
+ (NSString *)monthToEnglish;

/**
 *  读取英文日期 1st
 */
+ (NSString *)dayToEnglish;

/**
 *  读取英文格式日期 January 1st + (时分秒+年月),用作唯一标识符
 */
+ (NSString *)dateToEnglishID;

/**
 *  读取英文格式日期January 1st
 */
+ (NSString *)dateToEnglish;

@end
