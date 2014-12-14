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
#import "Masonry.h"

// 定义这个宏可以使用一些更简洁的方法
#define MAS_SHORTHAND

// 定义这个宏可以使用自动装箱功能
#define MAS_SHORTHAND_GLOBALS


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
    if (note.imageNames.count != 0) { // 如果该页有配图
        if (self.curImages == nil) { // 如果该页是新页, (比如 1 2 3 跳转 2 3 4 , 4就是新页, 2,3是旧页, 旧页不需要去沙盒读取图片, 新页需要去沙盒读取图片)
            // 这里循环添加image, 先取出第一张配图,存进数组
            UIImage *image = [UIImage imageWithContentsOfFile:[SNImageTool imagePath:note.imageNames[0]]];
            [self.curImages addObject:image];
            // 先把固定imageView显示出来, 显示配图名数组里的第一张
            self.imageView.image = image;
            
            // 显示配图名数组里的其他图片
            
            NSLog(@"%@",note.imageNames);
            
        } else {
            // 这里循环添加数组中的image
//            self.imageView.image = self.curImages;
        }
        
        if (Iphone) self.imageViewHeightCons.constant = 280;
        else self.imageViewHeightCons.constant = 560;
        } else {
            self.imageView.image = nil;
            self.imageViewHeightCons.constant = 0;
        }
}

@end
