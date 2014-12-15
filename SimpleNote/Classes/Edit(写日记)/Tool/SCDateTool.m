//
//  SCDateTool.m
//  SimpleNote
//
//  Created by Jason on 14/12/15.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SCDateTool.h"

@interface SCDateTool()

@end

@implementation SCDateTool

static NSDictionary *_dayDict;
static NSDateFormatter *_dateFormatter;

+ (void)initialize {
    
    _dayDict = [NSDictionary dictionaryWithObjects:@[@"1st",@"2nd",@"3rd",@"4th",@"5th",@"6th",@"7th",@"8th",@"9th",@"10th",@"11th",@"12th",@"13th",@"14th",@"15th",@"16th",@"17th",@"18th",@"19th",@"20th",@"21th",@"22th",@"23th",@"24th",@"25th",@"26th",@"27th",@"28th",@"29th",@"30th",@"31th"] forKeys:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"]];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
}

+ (NSString *)dateWithYear {
    [_dateFormatter setDateFormat:@"yyyy"];
    NSString *yearStr = [_dateFormatter stringFromDate:[NSDate date]];
    return yearStr;
}

+ (NSString *)dateWithYear_zh {
    [_dateFormatter setDateFormat:@"yyyy年"];
    NSString *yearStr = [_dateFormatter stringFromDate:[NSDate date]];
    return yearStr;
}

+ (NSString *)dateWithMonth {
    [_dateFormatter setDateFormat:@"MM"];
    NSString *monthStr = [_dateFormatter stringFromDate:[NSDate date]];
    return monthStr;
}

+ (NSString *)dateWithMonth_en {
    [_dateFormatter setDateFormat:@"MMMM"];
    NSString *monthStr_en = [_dateFormatter stringFromDate:[NSDate date]];
    return monthStr_en;
}

+ (NSString *)dateWithMonth_zh {
    [_dateFormatter setDateFormat:@"MM月"];
    NSString *monthStr_zh = [_dateFormatter stringFromDate:[NSDate date]];
    return monthStr_zh;
}

+ (NSString *)dateWithDay {
    [_dateFormatter setDateFormat:@"d"];
    NSString *dayStr = [_dateFormatter stringFromDate:[NSDate date]];
    return dayStr;
}

+ (NSString *)dateWithDay_0 {
    [_dateFormatter setDateFormat:@"dd"];
    NSString *dayStr_0 = [_dateFormatter stringFromDate:[NSDate date]];
    return dayStr_0;
}

+ (NSString *)dateWithDay_en {
    [_dateFormatter setDateFormat:@"d"];
    NSString *dayStr_en = [_dayDict objectForKey:[_dateFormatter stringFromDate:[NSDate date]]];
    return dayStr_en;
}

+ (NSString *)dateWithDay_zh {
    [_dateFormatter setDateFormat:@"d日"];
    NSString *dayStr_zh = [_dayDict objectForKey:[_dateFormatter stringFromDate:[NSDate date]]];
    return dayStr_zh;
}

+ (NSString *)dateWithHour {
    [_dateFormatter setDateFormat:@"H"];
    NSString *hourStr = [_dateFormatter stringFromDate:[NSDate date]];
    return hourStr;
}

+ (NSString *)dateWithHour_0 {
    [_dateFormatter setDateFormat:@"HH"];
    NSString *hourStr = [_dateFormatter stringFromDate:[NSDate date]];
    return hourStr;
}

+ (NSString *)dateWithMinute {
    [_dateFormatter setDateFormat:@"mm"];
    NSString *minuteStr = [_dateFormatter stringFromDate:[NSDate date]];
    return minuteStr;
}

+ (NSString *)dateWithSecond {
    [_dateFormatter setDateFormat:@"ss"];
    NSString *secondStr = [_dateFormatter stringFromDate:[NSDate date]];
    return secondStr;
}

+ (NSString *)dateWithTime {
    NSString *timeStr = [NSString stringWithFormat:@"%@:%@", [SCDateTool dateWithHour], [SCDateTool dateWithMinute]];
    return timeStr;
}

+ (NSString *)dateWithTime_0 {
    NSString *timeStr_0 = [NSString stringWithFormat:@"%@:%@", [SCDateTool dateWithHour_0], [SCDateTool dateWithMinute]];
    return timeStr_0;
}

+ (NSString *)dateWithDetailTime {
    NSString *detailTimeStr = [NSString stringWithFormat:@"%@:%@", [SCDateTool dateWithHour], [SCDateTool dateWithTime]];
    return detailTimeStr;
}

+ (NSString *)dateWithDetailTime_0 {
    NSString *detailTimeStr_0 = [NSString stringWithFormat:@"%@:%@", [SCDateTool dateWithHour_0], [SCDateTool dateWithTime_0]];
    return detailTimeStr_0;
}

+ (NSString *)dateWithDate {
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@", [SCDateTool dateWithMonth], [SCDateTool dateWithDay]];
    return dateStr;
}

+ (NSString *)dateWithDate_en {
    NSString *dateStr_en = [NSString stringWithFormat:@"%@ %@", [SCDateTool dateWithMonth_en], [SCDateTool dateWithDay_en]];
    return dateStr_en;
}

+ (NSString *)dateWithDate_zh {
    NSString *dateStr_zh = [NSString stringWithFormat:@"%@%@", [SCDateTool dateWithMonth_zh], [SCDateTool dateWithDay_zh]];
    return dateStr_zh;
}

+ (NSString *)dateWithDetailDate {
    NSString *detailDateStr = [NSString stringWithFormat:@"%@-%@", [SCDateTool dateWithYear], [SCDateTool dateWithDate]];
    return detailDateStr;
}

+ (NSString *)dateWithDetailDateAndTime {
    NSString *detailDateAndTimeStr = [NSString stringWithFormat:@"%@ %@", [SCDateTool dateWithDetailDate], [SCDateTool dateWithTime]];
    return detailDateAndTimeStr;
}

+ (NSString *)dateWithDetailDateAndDetailTime {
    NSString *detailDateAndDetailTimeStr = [NSString stringWithFormat:@"%@ %@", [SCDateTool dateWithDetailDate], [SCDateTool dateWithDetailTime]];
    return detailDateAndDetailTimeStr;
}

+ (NSString *)dateWithDateID {
    NSString *yearStr = [SCDateTool dateWithYear];
    NSString *monthStr = [SCDateTool dateWithMonth];
    NSString *dayStr = [SCDateTool dateWithDay_0];
    NSString *hourStr = [SCDateTool dateWithHour_0];
    NSString *minuteStr = [SCDateTool dateWithMinute];
    NSString *secondStr = [SCDateTool dateWithSecond];
    NSString *dateID = [NSString stringWithFormat:@"%@%@%@_%@%@%@", yearStr, monthStr, dayStr, hourStr, minuteStr, secondStr];
    return dateID;
}






@end
