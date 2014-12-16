//
//  SNNoteViewController.h
//  SimpleNote
//
//  Created by Jason on 14/12/4.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNNoteModel, SNNoteView, SNListViewController;

@interface SNNoteViewController : UIViewController
/**
 *  传递过来的当前模型数组下标
 */
@property (nonatomic, assign) int index;

/**
 *  传递过来的模型数组
 */
@property (nonatomic, strong) NSMutableArray *notes;

/**
 *  编辑日记
 */
@property (nonatomic, copy) void(^editNote)(SNNoteModel *newNote);

/**
 *  删除日记
 */
@property (nonatomic, copy) void(^deleteNote)(int curIndex);

@end
