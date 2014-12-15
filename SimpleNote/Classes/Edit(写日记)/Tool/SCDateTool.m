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
    ;
    _dayDict = [NSDictionary dictionaryWithObjects:@[@"1st",@"2nd",@"3rd",@"4th",@"5th",@"6th",@"7th",@"8th",@"9th",@"10th",@"11th",@"12th",@"13th",@"14th",@"15th",@"16th",@"17th",@"18th",@"19th",@"20th",@"21th",@"22th",@"23th",@"24th",@"25th",@"26th",@"27th",@"28th",@"29th",@"30th",@"31th"] forKeys:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    _dateComponents = [calendar components:kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond fromDate:[NSDate date]];

}


+ (NSString *)monthToEnglish {
    CGFloat month = _dateComponents.month;

    NSString *monthStr = [_monthDict objectForKey:[NSString stringWithFormat:@"%.f", month]];
    return monthStr;
}


+ (NSString *)dayToEnglish {
    CGFloat day = _dateComponents.day;
    NSString *dayStr = [_dayDict objectForKey:[NSString stringWithFormat:@"%.f", day]];
    return dayStr;
}

+ (NSString *)dateToEnglishID {
    // 获取日历
    CGFloat year = _dateComponents.year;
    CGFloat hour = _dateComponents.hour;
    CGFloat minute = _dateComponents.minute;
    CGFloat second = _dateComponents.second;
    
    NSString *yearStr = [NSString stringWithFormat:@"%02.f", year];
    NSString *hourStr = [NSString stringWithFormat:@"%02.f", hour];
    NSString *minuteStr = [NSString stringWithFormat:@"%02.f", minute];
    NSString *secondStr = [NSString stringWithFormat:@"%02.f", second];
    NSString *imageID = [[SCDateTool dateToEnglish] stringByAppendingString:[NSString stringWithFormat:@"_%@_%@%@%@", yearStr, hourStr, minuteStr, secondStr]];
    return imageID;
}

+ (NSString *)dateToEnglish {
    NSString *date = [[SCDateTool monthToEnglish] stringByAppendingString:[NSString stringWithFormat:@" %@", [SCDateTool dayToEnglish]]];
    return date;
}







@end
