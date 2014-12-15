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

static NSDictionary *_monthDict;
static NSDictionary *_dayDict;
static NSDateComponents *_dateComponents;

+ (void)initialize {
    _monthDict = [NSDictionary dictionaryWithObjects:@[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"] forKeys:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
    
    _dayDict = [NSDictionary dictionaryWithObjects:@[@"1st",@"2nd",@"3rd",@"4th",@"5th",@"6th",@"7th",@"8th",@"9th",@"10th",@"11th",@"12th",@"13th",@"14th",@"15th",@"16th",@"17th",@"18th",@"19th",@"20th",@"21th",@"22th",@"23th",@"24th",@"25th",@"26th",@"27th",@"28th",@"29th",@"30th",@"31th"] forKeys:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    _dateComponents = [calendar components:kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond fromDate:[NSDate date]];

}

+ (NSString *)dateWithYear {
    CGFloat year = _dateComponents.year;
    NSString *yearStr = [NSString stringWithFormat:@"%.f", year];
    return yearStr;
}

+ (NSString *)dateWithYear_zh {
    CGFloat year = _dateComponents.year;
    NSString *yearStr_zh = [NSString stringWithFormat:@"%.f年", year];
    return yearStr_zh;
}

+ (NSString *)dateWithMonth {
    CGFloat month = _dateComponents.month;
    NSString *monthStr = [NSString stringWithFormat:@"%.f", month];
    return monthStr;
}

+ (NSString *)dateWithMonth_0 {
    CGFloat month = _dateComponents.month;
    NSString *monthStr_0 = [NSString stringWithFormat:@"%02.f", month];
    return monthStr_0;
}

+ (NSString *)dateWithMonth_en {
    CGFloat month = _dateComponents.month;
    NSString *monthStr_en = [_monthDict objectForKey:[NSString stringWithFormat:@"%.f", month]];
    return monthStr_en;
}

+ (NSString *)dateWithMonth_zh {
    CGFloat month = _dateComponents.month;
    NSString *monthStr_zh = [NSString stringWithFormat:@"%.f月", month];
    return monthStr_zh;
}

+ (NSString *)dateWithDay {
    CGFloat day = _dateComponents.day;
    NSString *dayStr = [NSString stringWithFormat:@"%.f", day];
    return dayStr;
}

+ (NSString *)dateWithDay_0 {
    CGFloat day = _dateComponents.day;
    NSString *dayStr_0 = [NSString stringWithFormat:@"%02.f", day];
    return dayStr_0;
}

+ (NSString *)dateWithDay_en {
    CGFloat day = _dateComponents.day;
    NSString *dayStr_en = [_dayDict objectForKey:[NSString stringWithFormat:@"%.f", day]];
    return dayStr_en;
}

+ (NSString *)dateWithDay_zh {
    CGFloat day = _dateComponents.day;
    NSString *dayStr_zh = [NSString stringWithFormat:@"%.f日", day];
    return dayStr_zh;
}

+ (NSString *)dateWithHour {
    CGFloat hour = _dateComponents.hour;
    NSString *hourStr = [NSString stringWithFormat:@"%.f", hour];
    return hourStr;
}

+ (NSString *)dateWithHour_0 {
    CGFloat hour = _dateComponents.hour;
    NSString *hourStr_0 = [NSString stringWithFormat:@"%02.f", hour];
    return hourStr_0;}

+ (NSString *)dateWithMinute {
    CGFloat minute = _dateComponents.minute;
    NSString *minuteStr = [NSString stringWithFormat:@"%02.f", minute];
    return minuteStr;
}

+ (NSString *)dateWithSecond {
    CGFloat second = _dateComponents.second;
    NSString *secondStr = [NSString stringWithFormat:@"%02.f", second];
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
    NSString *monthStr = [SCDateTool dateWithMonth_0];
    NSString *dayStr = [SCDateTool dateWithDay_0];
    NSString *hourStr = [SCDateTool dateWithHour_0];
    NSString *minuteStr = [SCDateTool dateWithMinute];
    NSString *secondStr = [SCDateTool dateWithSecond];
    NSString *dateID = [NSString stringWithFormat:@"%@%@%@_%@%@%@", yearStr, monthStr, dayStr, hourStr, minuteStr, secondStr];
    return dateID;
}






@end
