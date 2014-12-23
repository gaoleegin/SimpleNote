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
#import "SCImageTool.h"
#import "Common.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "SNNoteViewController.h"
#import "SCDateTool.h"
#import "DLCImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>



@interface SNEditViewController ()<UITextViewDelegate, UIAlertViewDelegate, DLCImagePickerDelegate>
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

/**
 *  是编辑还是写新日记
 */
@property (nonatomic, assign, getter=isEditing) BOOL editing;

/**
 *  删除日记
 */
- (IBAction)deleteNote;

@property (weak, nonatomic) IBOutlet UIButton *deleteNoteButton;


@property (nonatomic, assign) int preImageCount;


@property (weak, nonatomic) IBOutlet UIButton *deleteButton1;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton2;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton3;

- (IBAction)deleteImage1:(UIButton *)sender;

- (IBAction)deleteImage2:(UIButton *)sender;

- (IBAction)deleteImage3:(UIButton *)sender;

@property (nonatomic, strong) UIImage *image1;

@property (nonatomic, strong) UIImage *image2;

@property (nonatomic, strong) UIImage *image3;

@property (nonatomic, strong) NSMutableArray *preImages;


@end

@implementation SNEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commitBtn.enabled = NO;
    self.addImageCount = 1;
    
    // 编辑页面初始化
    [self setUpEditView];
    
    // 将编辑前的图片储存起来, 如果用户取消编辑, 则复原编辑前的图片
    if (self.images.count) {
        self.image1 = self.images[0];
        [self.preImages addObject:self.image1];
        if (self.images.count > 1) {
            self.image2 = self.images[1];
            [self.preImages addObject:self.image2];
            if (self.images.count > 2) {
                self.image3 = self.images[2];
                [self.preImages addObject:self.image3];
            }
        }
    }
}


- (void)setUpEditView {
    if (self.curNote != nil) {
        self.navigationItem.title = @"编辑";
        self.deleteNoteButton.hidden = NO;
        self.editing = YES;
        [self.textView setText:self.curNote.body];
        if (self.curNote.body.length) {
            self.textView.placeholderLabel.hidden = YES;
        } else {
            self.textView.placeholderLabel.hidden = NO;
        }
        self.images = self.curImages;
        self.preImageCount = (int)self.curImages.count;
        if (self.images.count) {
            self.addImageView.image = self.curImages[0];
            self.deleteButton1.hidden = NO;
            self.addImageCount++;
            if (self.images.count > 1) {
                self.addImageView2.image = self.curImages[1];
                self.deleteButton2.hidden = NO;
                self.addImageCount++;
                if (self.images.count > 2) {
                    self.addImageView3.image = self.curImages[2];
                    self.deleteButton3.hidden = NO;
                    self.addImageCount++;
                }
            }
        }
    } else {
        self.navigationItem.title = @"写日记";
        self.deleteNoteButton.hidden = YES;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (NSMutableArray *)preImages {
    if (!_preImages) {
        _preImages = [NSMutableArray array];
    }
    return _preImages;
}


#pragma mark - 跳转照片选择控制器
- (IBAction)addImage {
    /*
    UIImagePickerControllerSourceTypePhotoLibrary,
    UIImagePickerControllerSourceTypeCamera,
    UIImagePickerControllerSourceTypeSavedPhotosAlbum
    */
    if (self.addImageCount == 4) {
        [self.view showSheetWithContent:@"最多添加三张照片" coorY:0.4];
        return;
    } else if (self.addImageCount == 5){
        [self.view showSheetWithContent:@"最多添加三张照片" coorY:0.4];
        return;
    }
    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
//        UIImagePickerController * imagePickerVc = [[UIImagePickerController alloc] init];
//        imagePickerVc.delegate = self;
//        imagePickerVc.allowsEditing = YES;
//        imagePickerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        
//        [self presentViewController:imagePickerVc animated:YES completion:nil];
//    }
    
    DLCImagePickerController *picker = [[DLCImagePickerController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];

}

#pragma mark - 照片选择控制器代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if (info) {
        // 1.1.1判断图片选择器是否允许编辑
//        UIImage *resultImage = [info objectForKey:@"image"];
//        NSString *const UIImagePickerControllerImage = @"image";  // a UIImage
//        NSString *const UIImagePickerControllerDate = @"date";   // a Date

        UIImage *resultImage = info[UIImagePickerControllerImage];
//        if (picker.allowsEditing) {
//            // 允许编辑
//            resultImage = info[UIImagePickerControllerEditedImage];
//        }else
//        {
//            resultImage = info[UIImagePickerControllerOriginalImage];
//        }
        
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageDataToSavedPhotosAlbum:info[UIImagePickerControllerDate] metadata:nil completionBlock:^(NSURL *assetURL, NSError *error)
         {
             if (error) {
//                 NSLog(@"ERROR: the image failed to be written");
             }
             else {
//                 NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
             }
         }];
        
        
        // 添加图片至数组
        [self.images addObject:resultImage];
        // 设置图片到图片容器上
        switch (self.addImageCount) {
            case 1:
                self.addImageView.image = resultImage;
                self.deleteButton1.hidden = NO;
                break;
            case 2:
                self.addImageView2.image = resultImage;
                self.deleteButton2.hidden = NO;
                break;
            case 3:
                self.addImageView3.image = resultImage;
                if (Iphone) self.addImageCount++;
                self.deleteButton3.hidden = NO;
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
    
    
    [self.images removeAllObjects];
    [self.images addObjectsFromArray:self.preImages];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 收回键盘
    [self.textView resignFirstResponder];
    
}


/**
 *  发表日记
 */
- (IBAction)dismissEditVcWithContent {

    // 存储图片
    NSMutableArray *imageNames = [NSMutableArray array];
    for (UIImage *image in self.images) {
        // 图片路径
//        NSLog(@"%@", self.images);
        NSString *imageName = [NSString stringWithFormat:@"%@_%02d", [SCDateTool dateWithDateID], self.i++];
        NSString *imageNameID = [imageName stringByAppendingPathExtension:@"jpg"];
        [SCImageTool save:image imageName:imageNameID];
        [imageNames addObject:imageNameID];
//        NSLog(@"image = %@---ID = %@", image, imageNameID);
    }
    
    
    
    if (self.isEditing) {
        NSDictionary *noteDict = @{@"date":self.curNote.date, @"body":self.textView.text, @"imageNames":imageNames};
        SNNoteModel *newNote = [SNNoteModel objectWithKeyValues:noteDict];

        if (self.noteVc.editNote) {
            self.noteVc.editNote(newNote);
        }
    } else {
        NSDictionary *noteDict = @{@"date":[SCDateTool dateWithDate_en], @"body":self.textView.text, @"imageNames":imageNames};
        SNNoteModel *newNote = [SNNoteModel objectWithKeyValues:noteDict];

        if (self.listVc.saveNote) {
            self.listVc.saveNote(newNote);
        }
    }

    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 收回键盘
    [self.textView resignFirstResponder];
}

- (void)textViewDidChange:(SCPlaceholderTextView *)textView {
    if (self.textView.text.length > 0) {
        self.commitBtn.enabled = YES;
    } else {
        if (self.images.count) {
            self.commitBtn.enabled = YES;
        } else {
        self.commitBtn.enabled = NO;
        }
    }
}

- (IBAction)deleteNote {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除日记" message:@"若删除日记, 其文本将不可恢复, 照片依然保留在本地相册中" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark - <UIAlertDelegate>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (self.noteVc.deleteNote) {
            self.noteVc.deleteNote(self.curIndex);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)deleteImage1:(UIButton *)sender {
    if (self.textView.text.length) {
        self.commitBtn.enabled = YES;
    } else {
        self.commitBtn.enabled = NO;
    }
    [self.images removeObjectAtIndex:0];
    if (self.addImageView2.image) {
        self.addImageView.image = self.addImageView2.image;
        if (self.addImageView3.image) {
            self.addImageView2.image = self.addImageView3.image;
            self.addImageView3.image = nil;
            self.deleteButton3.hidden = YES;
        } else {
            self.addImageView2.image = nil;
            self.deleteButton2.hidden = YES;
        }
    } else {
        self.addImageView.image = nil;
        self.deleteButton1.hidden = YES;
    }
    self.addImageCount--;
}

- (IBAction)deleteImage2:(UIButton *)sender {
    [self.images removeObjectAtIndex:1];
    if (self.addImageView3.image) {
        self.addImageView2.image = self.addImageView3.image;
        self.addImageView3.image = nil;
        self.deleteButton3.hidden = YES;
    } else {
        self.addImageView2.image = nil;
        self.deleteButton2.hidden = YES;
    }
    self.addImageCount--;
}

- (IBAction)deleteImage3:(UIButton *)sender {
    [self.images removeObjectAtIndex:2];
    self.addImageView3.image = nil;
    self.deleteButton3.hidden = YES;
    self.addImageCount--;
}
@end
