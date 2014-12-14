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
/**
 *  图片容器视图
 */
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;
/**
 *  图片视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView2;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView3;





@property (nonatomic, assign) int addImageCount;
@end

@implementation SNEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commitBtn.enabled = NO;
    self.addImageCount = 0;
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
#warning 在这里设置图片容器逻辑
        // 1.1.2设置图片到图片容器上
        switch (self.addImageCount) {
            case 0:
                self.addImageView.image = resultImage;
                break;
            case 1:
                self.addImageView2.image = resultImage;
                break;
            case 2:
                self.addImageView3.image = resultImage;
                break;
            default:
                break;
        }
    }
    [self dismissViewControllerAnimated:YES completion:^{
        self.commitBtn.enabled = YES;
        self.addImageCount++;
    }];
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
         kCFCalendarUnitHour = (1UL << 5),
         kCFCalendarUnitMinute = (1UL << 6),
         kCFCalendarUnitSecond = (1UL << 7),
     */
    NSDateComponents *dateComponents = [calendar components:kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond fromDate:[NSDate date]];
//    CGFloat year = dateComponents.year;
    CGFloat month = dateComponents.month;
    CGFloat day = dateComponents.day;
    CGFloat hour = dateComponents.hour;
    CGFloat minute = dateComponents.minute;
    CGFloat second = dateComponents.second;
    
    NSString *monthStr = [self.monthDict objectForKey:[NSString stringWithFormat:@"%.f", month]];
    NSString *dayStr = [self.dayDict objectForKey:[NSString stringWithFormat:@"%.f", day]];
    NSString *hourStr = [NSString stringWithFormat:@"%02.f", hour];
    NSString *minuteStr = [NSString stringWithFormat:@"%02.f", minute];
    NSString *secondStr = [NSString stringWithFormat:@"%02.f", second];
    NSString *date = [monthStr stringByAppendingString:[NSString stringWithFormat:@" %@", dayStr]];
    NSString *imageID = [date stringByAppendingString:[NSString stringWithFormat:@"%@%@%@", hourStr, minuteStr, secondStr]];
    
    
    // 图片路径
    NSString *imageName = [imageID stringByAppendingPathExtension:@"png"];
    [SNImageTool save:self.addImageView.image imageName:imageName];

    NSDictionary *noteDict = @{@"date":date, @"body":self.textView.text, @"imageName":imageName};
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
