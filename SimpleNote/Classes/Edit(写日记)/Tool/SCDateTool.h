//
//  SCDateTool.h
//  SimpleNote
//
//  Created by Jason on 14/12/15.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//
//  直接取出当前日期的各种格式

#import <UIKit/UIKit.h>

@interface SCDateTool : NSObject

/**
 *  读取年份 例:2014
 */
+ (NSString *)dateWithYear;

/**
 *  读取中文年份 列:2014年
 */
+ (NSString *)dateWithYear_zh;

/**
 *  读取月份 例:1
 */
+ (NSString *)dateWithMonth;

/**
 *  读取月份 例:01
 */
+ (NSString *)dateWithMonth_0;

/**
 *  读取英文月份 例:January
 */
+ (NSString *)dateWithMonth_en;

/**
 *  读取中文月份 例:1月
 */
+ (NSString *)dateWithMonth_zh;

/**
 *  读取日 例:1
 */
+ (NSString *)dateWithDay;

/**
 *  读取日 例:01
 */
+ (NSString *)dateWithDay_0;

/**
 *  读取英文日 例:1st
 */
+ (NSString *)dateWithDay_en;

/**
 *  读取中文日 例:1日
 */
+ (NSString *)dateWithDay_zh;

/**
 *  读取时 例:3
 */
+ (NSString *)dateWithHour;

/**
 *  读取时 例:03
 */
+ (NSString *)dateWithHour_0;

/**
 *  读取分 例:07
 */
+ (NSString *)dateWithMinute;

/**
 *  读取秒 例:13
 */
+ (NSString *)dateWithSecond;

/**
 *  读取时间 例:3:07
 */
+ (NSString *)dateWithTime;

/**
 *  读取时间 例:03:07
 */
+ (NSString *)dateWithTime_0;

/**
 *  读取详细时间 例:3:07:13
 */
+ (NSString *)dateWithDetailTime;

/**
 *  读取详细事件 例:03:07:13
 */
+ (NSString *)dateWithDetailTime_0;

/**
 *  读取通用日期 例:1-1
 */
+ (NSString *)dateWithDate;

/**
 *  读取英文日期 例:January 1st
 */
+ (NSString *)dateWithDate_en;

/**
 *  读取中文日期 例:1月1日
 */
+ (NSString *)dateWithDate_zh;

/**
 *  读取通用详细日期 例:2014-1-1
 */
+ (NSString *)dateWithDetailDate;

/**
 *  读取通用详细日期+时间 例:2014-1-1 3:07
 */
+ (NSString *)dateWithDetailDateAndTime;

/**
 *  读取通用详细日期+详细时间 例:2014-1-1 3:07:13
 */
+ (NSString *)dateWithDetailDateAndDetailTime;

/**
 *  读取唯一日期ID 例:20140101_030713
 */
+ (NSString *)dateWithDateID;




@end
