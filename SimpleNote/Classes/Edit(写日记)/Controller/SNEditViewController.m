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

@interface SNEditViewController ()<UITextViewDelegate>
/**
 *  取消
 */
- (IBAction)dismissEditVc;
/**
 *  发表
 */
- (IBAction)dismissEditVcWithContent;
/**
 *  发表按钮
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commitBtn;

@property (weak, nonatomic) IBOutlet SCPlaceholderTextView *textView;
/**
 *  月转换字典
 */
@property (nonatomic, strong) NSDictionary *monthDict;
/**
 *  日转换字典
 */
@property (nonatomic, strong) NSDictionary *dayDict;


- (IBAction)addImage;

@end

@implementation SNEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commitBtn.enabled = NO;
}

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

- (IBAction)addImage {
    UIImagePickerController * imagePickerVc = [[UIImagePickerController alloc] init];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (IBAction)dismissEditVc {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 收回键盘
    [self.textView resignFirstResponder];
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
    
    
    NSDictionary *noteDict = @{@"date":date, @"body":self.textView.text};
    SNNoteModel *newNote = [SNNoteModel noteWithDict:noteDict];
    if (self.listVc.saveNote) {
        self.listVc.saveNote(newNote);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 收回键盘
    [self.textView resignFirstResponder];
}

- (void)textViewDidChange:(SCPlaceholderTextView *)textView {
    if (self.textView.text.length > 0) {
        self.commitBtn.enabled = YES;
    } else {
        self.commitBtn.enabled = NO;
    }
}
@end
