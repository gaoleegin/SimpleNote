//
//  SNEditViewController.m
//  SimpleNote
//
//  Created by Jason on 14/12/10.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNEditViewController.h"
#import "SCPlaceholderTextView.h"
#import "SNListViewController.h"
#import "SNNoteModel.h"

@interface SNEditViewController ()
/**
 *  取消
 */
- (IBAction)dismissEditVc;
/**
 *  发表
 */
- (IBAction)dismissEditVcWithContent;

@property (weak, nonatomic) IBOutlet SCPlaceholderTextView *textView;

@property (nonatomic, strong) NSDictionary *monthDict;
@property (nonatomic, strong) NSDictionary *dayDict;

@end

@implementation SNEditViewController

#pragma mark - 懒加载
- (NSDictionary *)monthDict {
    if (!_monthDict) {
        _monthDict = [NSDictionary dictionaryWithObjects:@[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"] forKeys:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
    }
    return _monthDict;
}

- (NSDictionary *)dayDict {
    if (!_dayDict) {
        _dayDict = [NSDictionary dictionaryWithObjects:@[@"1st",@"2nd",@"3rd",@"4th",@"5th",@"6th",@"7th",@"8th",@"9th",@"10th",@"11th",@"12th",@"13th",@"14th",@"15th",@"16th",@"17th",@"18th",@"19th",@"20th",@"21th",@"22th",@"23th",@"24th",@"25th",@"26th",@"27th",@"28th",@"29th",@"30th",@"31th"] forKeys:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"]];
    }
    return _dayDict;
}

- (IBAction)dismissEditVc {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissEditVcWithContent {
    // 获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获取日期组件
    /**
         NSCalendarUnitYear               = kCFCalendarUnitYear,
         NSCalendarUnitMonth              = kCFCalendarUnitMonth,
         NSCalendarUnitDay                = kCFCalendarUnitDay,
     */
    NSDateComponents *dateComponents = [calendar components:kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay fromDate:[NSDate date]];
//    CGFloat year = dateComponents.year;
    CGFloat month = dateComponents.month;
    CGFloat day = dateComponents.day;
    
    NSString *monthStr = [self.monthDict objectForKey:[NSString stringWithFormat:@"%.f", month]];
    NSString *dayStr = [self.dayDict objectForKey:[NSString stringWithFormat:@"%.f", day]];
    NSString *date = [monthStr stringByAppendingString:[NSString stringWithFormat:@" %@", dayStr]];
    
    SNNoteModel *newNote = [SNNoteModel noteWithDict:@{@"date":date, @"body":self.textView.text}];
    if (self.listVc.saveNote) {
        self.listVc.saveNote(newNote);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
