//
//  SNNoteView.m
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNNoteView.h"
#import "SNBodyLabel.h"
#import "SNNoteModel.h"
#import "SNImageTool.h"
#import "Common.h"

@interface SNNoteView()
/**
 *  日期标签
 */
@property (weak, nonatomic) IBOutlet UILabel *date;
/**
 *  正文标签
 */
@property (weak, nonatomic) IBOutlet SNBodyLabel *textLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *imageViewHeightCons;

@end

@implementation SNNoteView

/**
 *  更新UI数据
 *
 *  @param note 日记模型
 */
- (void)setNote:(SNNoteModel *)note {
    _note = note;
    self.date.text = note.date;
    self.textLabel.text = note.body;
    if (note.imageName) {
        dispatch_async(
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                           // 执行耗时的异步操作...
                           UIImage *image = [UIImage imageWithContentsOfFile:[SNImageTool imagePath:note.imageName]];
                           dispatch_async(dispatch_get_main_queue(), ^{
                               // 回到主线程，执行UI刷新操作
                               self.imageView.image = image;
                           });
                       });
        if (Iphone) self.imageViewHeightCons.constant = 280;
        else self.imageViewHeightCons.constant = 560;
        } else {
            self.imageView.image = nil;
            self.imageViewHeightCons.constant = 0;
        }
}

@end
