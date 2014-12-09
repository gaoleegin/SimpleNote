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

@interface SNNoteView()
/**
 *  日期标签
 */
@property (weak, nonatomic) IBOutlet UILabel *date;
/**
 *  正文标签
 */
@property (weak, nonatomic) IBOutlet SNBodyLabel *textLabel;

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
}


@end
