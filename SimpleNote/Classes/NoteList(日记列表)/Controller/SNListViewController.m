//
//  SNListViewController.m
//  SimpleNote
//
//  Created by Jason on 14/12/4.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNListViewController.h"
#import "SNNoteViewController.h"
#import "SNListViewCell.h"
#import "SNNoteModel.h"
#import "Common.h"
#import "SNEditViewController.h"
#import "SNNoteTool.h"
#import "MJExtension.h"
#import "SCDateTool.h"
#import "SCImageTool.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "Masonry.h"
#import "UIView+Extension.h"
#import "DLCImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>

// 定义这个宏可以使用一些更简洁的方法
#define MAS_SHORTHAND

// 定义这个宏可以使用自动装箱功能
#define MAS_SHORTHAND_GLOBALS


@interface SNListViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, DLCImagePickerDelegate>

- (IBAction)lockView;

@property (nonatomic, strong) NSMutableArray *notes;

@property (nonatomic, strong) NSMutableArray *dictArr;

- (IBAction)showEditView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *lockButton;

@property (nonatomic, strong) UIButton *cover;

@property (nonatomic, weak) UIButton *unlockButton;

- (IBAction)takePhoto;

@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;

@property (weak, nonatomic) IBOutlet UIButton *takePhotoButtonWithTouchID;
@end

@implementation SNListViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加覆盖蒙版
    [self showCover];
    // 指纹识别
    [self checkTouchID];
    
    // 从沙盒读取数据
    _notes = [SNNoteTool notes];
    
    if (!_notes) {
        
        // 程序第一次载入时候显示
        UIImage *image1 = [UIImage imageNamed:@"dec28_windmill"];
        UIImage *image2 = [UIImage imageNamed:@"sep30_box"];
        NSString *image1Name = [NSString stringWithFormat:@"%@_01",[SCDateTool dateWithDateID]];
        NSString *image2Name = [NSString stringWithFormat:@"%@_02",[SCDateTool dateWithDateID]];

        [SCImageTool save:image1 imageName:[image1Name stringByAppendingPathExtension:@"png"]];
        [SCImageTool save:image2 imageName:[image2Name stringByAppendingPathExtension:@"png"]];
        
        NSMutableArray *image1Names = [NSMutableArray arrayWithObject:image1Name];
        NSMutableArray *image2Names = [NSMutableArray arrayWithObject:image2Name];
        
        NSDictionary *noteDict1 = @{@"date" : [SCDateTool dateWithDate_en], @"body" : @"我今天感觉自己萌萌哒!", @"imageNames" : image1Names};
        NSDictionary *noteDict2 = @{@"date" : [SCDateTool dateWithDate_en], @"body" : @"你呢?", @"imageNames" : image2Names};
        SNNoteModel *note1 = [SNNoteModel objectWithKeyValues:noteDict1];
        SNNoteModel *note2 = [SNNoteModel objectWithKeyValues:noteDict2];
        [self.notes addObjectsFromArray:@[note1, note2]];
        
        [SNNoteTool save:self.notes];
        
    }
    
    __weak typeof(self) weakSelf = self;
    self.saveNote = ^(SNNoteModel *newNote){
        [weakSelf.notes insertObject:newNote atIndex:0];
        [SNNoteTool save:weakSelf.notes];
        [weakSelf.tableView reloadData];
        if (weakSelf.notes.count > 1) {
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.view setSheetWithContent:@"保存了一篇日记" fontSize:14 fontColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] coorY:0.4];
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
        });
    };
    
    self.deleteNote = ^{
        [weakSelf performSelector:@selector(showAlert:) withObject:@"删除了一篇日记" afterDelay:0.3];
    };
}

- (void)showAlert:(NSString *)text {
    [self.view setSheetWithContent:text fontSize:14 fontColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] coorY:0.3];
}


- (void)checkTouchID {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    context.localizedFallbackTitle = @""; // fallback按钮需要设置为空字符串, 才能隐藏
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"使用指纹登录", nil) reply:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.cover removeFromSuperview];
                });
            } else {
                
                if (error.code == LAErrorUserCancel) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 用户点击了取消, 显示解锁按钮
                        [self showUnlockButton];
                    });
                }
                
                if (error.code == LAErrorAuthenticationFailed) {
                    alert.message = @"再次验证";
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alert show];
                    });
                }
                
                if (error.code == LAErrorPasscodeNotSet) {
                    alert.message = @"未设密码";
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alert show];
                    });
                }
            }
        }];
    } else {
        
        if (error.code == kLAErrorTouchIDNotEnrolled) {
            // 没有登记指纹
            alert.message = @"请在设置里登记指纹";
            [alert show];
        }
        if (error.code == LAErrorTouchIDNotAvailable) {
            // 手机不支持TouchID
            self.lockButton.hidden = YES;
            self.takePhotoButton.hidden = NO;
            self.takePhotoButtonWithTouchID.hidden = YES;
            [self.cover removeFromSuperview];
        }
    }
}

- (void)showUnlockButton {
    UIButton *unlockButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.unlockButton = unlockButton;
    [unlockButton setImage:[UIImage imageNamed:@"button_locked"] forState:UIControlStateNormal];
    [unlockButton setImage:[UIImage imageNamed:@"button_locked_push"] forState:UIControlStateHighlighted];
    [unlockButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.cover addSubview:unlockButton];
    unlockButton.translatesAutoresizingMaskIntoConstraints = NO;
    [unlockButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //                    make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(100, 100, 100, 100));
        //                    make.left.and.top.equalTo(self.cover).with.offset(100);
        make.centerX.and.centerY.equalTo(self.cover).with.offset(0);
    }];
}

- (void)login{
    [self.unlockButton removeFromSuperview];
    [self checkTouchID];
}

#pragma mark - 懒加载
- (NSMutableArray *)notes {
    if (!_notes) {
        _notes = [NSMutableArray array];
    }
    return _notes;
}

- (NSMutableArray *)dictArr {
    if (!_dictArr) {
        _dictArr = [NSMutableArray array];
    }
    return _dictArr;
}

- (UIButton *)cover {
    if (!_cover) {
        UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
        _cover = cover;
        _cover.backgroundColor = [UIColor blackColor];
        _cover.alpha = 0.7;
        _cover.enabled = YES;
        _cover.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _cover;
}


- (void)showCover {
    [self.view addSubview:self.cover];
    
    [self.cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = (indexPath.row % 2) == 0 ? @"Cell1" : @"Cell2";
    
    SNListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.note = self.notes[indexPath.row];
        
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"list2Note" sender:indexPath];
    [UIApplication sharedApplication].statusBarHidden = YES;

    // 选中后恢复cell状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SNNoteViewController *noteVc = segue.destinationViewController;
    NSIndexPath *indexPath = sender;
    noteVc.index = (int)indexPath.row;
    noteVc.notes = self.notes;
    noteVc.listVc = self;
}


- (IBAction)lockView {
    [self showCover];
    [self showUnlockButton];
}

- (IBAction)showEditView {
    UIStoryboard *editSb = [UIStoryboard storyboardWithName:@"SNEditViewController" bundle:nil];
    SNEditViewController *editNc = [editSb instantiateInitialViewController];
    [self presentViewController:editNc animated:YES completion:nil];
    [editNc.childViewControllers[0] setListVc:self];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // 用户点击了取消, 显示解锁按钮
    if (buttonIndex == 0) {
        [self showUnlockButton];
    }
}


- (IBAction)takePhoto {
    DLCImagePickerController *picker = [[DLCImagePickerController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 照片选择控制器代理方法
- (void)imagePickerController:(DLCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (info) {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageDataToSavedPhotosAlbum:info[UIImagePickerControllerDate] metadata:nil completionBlock:nil];
    }
    [picker.view setSheetWithContent:@"已保存至本地相册"];
    [picker retakePhoto:nil];
    picker.photoCaptureButton.enabled = YES;
}

- (void)imagePickerControllerDidCancel:(DLCImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
