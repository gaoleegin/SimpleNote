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
#import "Common.h"
#import "UIView+Extension.h"
#import "MJExtension.h"

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

@property (weak, nonatomic) IBOutlet UIImageView *addImageViewForIpad;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView4;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView5;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView6;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView7;

@property (weak, nonatomic) IBOutlet UIImageView *addImageViewForIpad2;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView8;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView9;

@property (weak, nonatomic) IBOutlet UIImageView *addImageView10;
/**
 *  所有添加的图片数组
 */
@property (nonatomic, strong) NSMutableArray *images;
/**
 *  添加图片计数
 */
@property (nonatomic, assign) int addImageCount;
/**
 *  图片名后缀 - 用来区分同一篇日记的名字
 */
@property (nonatomic, assign) int i;
@end

@implementation SNEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commitBtn.enabled = NO;
    self.addImageCount = 1;
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

- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}


#pragma mark - 跳转照片选择控制器
- (IBAction)addImage {
    /*
    UIImagePickerControllerSourceTypePhotoLibrary,
    UIImagePickerControllerSourceTypeCamera,
    UIImagePickerControllerSourceTypeSavedPhotosAlbum
    */
    if (self.addImageCount == 4) {
        if (Iphone) [self.view setSheetWithContent:@"最多添加十张照片"];
        else [self.view setSheetWithContent:@"最多添加三张照片"];
        return;
    }
    
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
        // 添加图片至数组
        [self.images addObject:resultImage];
        // 设置图片到图片容器上
        switch (self.addImageCount) {
            case 1:
                self.addImageView.image = resultImage;
                break;
            case 2:
                self.addImageView2.image = resultImage;
                break;
            case 3:
                self.addImageView3.image = resultImage;
                if (Iphone) self.addImageCount++;
                break;
            case 4:
                self.addImageViewForIpad.image = resultImage;
                break;
            case 5:
                self.addImageView4.image = resultImage;
                break;
            case 6:
                self.addImageView5.image = resultImage;
                break;
            case 7:
                self.addImageView6.image = resultImage;
                break;
            case 8:
                self.addImageView7.image = resultImage;
                if (Iphone) self.addImageCount++;
                break;
            case 9:
                self.addImageViewForIpad2.image = resultImage;
                break;
            case 10:
                self.addImageView8.image = resultImage;
                break;
            case 11:
                self.addImageView9.image = resultImage;
                break;
            case 12:
                self.addImageView10.image = resultImage;
                break;
            default:
                break;
        }
    }
    self.commitBtn.enabled = YES;
    [self dismissViewControllerAnimated:YES completion:^{
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
    CGFloat year = dateComponents.year;
    CGFloat month = dateComponents.month;
    CGFloat day = dateComponents.day;
    CGFloat hour = dateComponents.hour;
    CGFloat minute = dateComponents.minute;
    CGFloat second = dateComponents.second;
    
    NSString *monthStr = [self.monthDict objectForKey:[NSString stringWithFormat:@"%.f", month]];
    NSString *dayStr = [self.dayDict objectForKey:[NSString stringWithFormat:@"%.f", day]];
    NSString *yearStr = [NSString stringWithFormat:@"%02.f", year];
    NSString *hourStr = [NSString stringWithFormat:@"%02.f", hour];
    NSString *minuteStr = [NSString stringWithFormat:@"%02.f", minute];
    NSString *secondStr = [NSString stringWithFormat:@"%02.f", second];
    NSString *date = [monthStr stringByAppendingString:[NSString stringWithFormat:@" %@", dayStr]];
    NSString *imageID = [date stringByAppendingString:[NSString stringWithFormat:@"_%@_%@%@%@", yearStr, hourStr, minuteStr, secondStr]];

    // 存储图片
    NSMutableArray *imageNames = [NSMutableArray array];
    for (UIImage *image in self.images) {
        // 图片路径
        NSString *imageName = [NSString stringWithFormat:@"%@_%02d", imageID, self.i++];
        NSString *imageNameID = [imageName stringByAppendingPathExtension:@"png"];
        [SNImageTool save:image imageName:imageNameID];
        [imageNames addObject:imageNameID];
    }
    
    NSDictionary *noteDict = @{@"date":date, @"body":self.textView.text, @"imageNames":imageNames};
    SNNoteModel *newNote = [SNNoteModel objectWithKeyValues:noteDict];
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
