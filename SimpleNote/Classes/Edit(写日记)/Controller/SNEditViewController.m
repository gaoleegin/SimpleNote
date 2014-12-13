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
#import <MobileCoreServices/MobileCoreServices.h>
#import "SNImageTool.h"

#define SNImagePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@interface SNEditViewController ()<UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
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

@property (weak, nonatomic) IBOutlet UIButton *addImageBtn;

- (IBAction)addImage;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView;
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

#pragma mark - 跳转照片选择控制器
- (IBAction)addImage {
    /*
    UIImagePickerControllerSourceTypePhotoLibrary,
    UIImagePickerControllerSourceTypeCamera,
    UIImagePickerControllerSourceTypeSavedPhotosAlbum
    */
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImagePickerController * imagePickerVc = [[UIImagePickerController alloc] init];
        imagePickerVc.delegate = self;
        imagePickerVc.allowsEditing = YES;
        imagePickerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

#pragma mark - 照片选择控制器代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqual:(NSString *)kUTTypeImage]) {
        // 1.1.1判断图片选择器是否允许编辑
        UIImage *resultImage = nil;
        if (picker.allowsEditing) {
            // 允许编辑
            resultImage = info[UIImagePickerControllerEditedImage];
        }else
        {
            resultImage = info[UIImagePickerControllerOriginalImage];
        }
        // 1.1.2设置图片到图片容器上
#warning 图片功能
        self.addImageView.image = resultImage;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissEditVc {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 收回键盘
    [self.textView resignFirstResponder];
}


/**
 *  发表日记
 */
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
    
    // 图片路径
    NSString *imageName = [date stringByAppendingPathExtension:@"png"];
    NSString *imagePath = [SNImagePath stringByAppendingPathComponent:imageName];
    [SNImageTool save:self.addImageView.image imagePath:imagePath];

    NSDictionary *noteDict = @{@"date":date, @"body":self.textView.text, @"imagePath":imagePath};
    SNNoteModel *newNote = [SNNoteModel noteWithDict:noteDict];
    if (self.listVc.saveNote) {
        self.listVc.saveNote(newNote);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 收回键盘
    [self.textView resignFirstResponder];
    

    
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)textViewDidChange:(SCPlaceholderTextView *)textView {
    if (self.textView.text.length > 0) {
        self.commitBtn.enabled = YES;
    } else {
        self.commitBtn.enabled = NO;
    }
}
@end
