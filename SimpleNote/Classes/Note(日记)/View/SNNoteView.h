//
//  SNNoteView.h
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNNoteModel;

@interface SNNoteView : UIView
/**
 *  日记模型
 */
@property (nonatomic, strong) SNNoteModel *note;
///**
// *  当前日记的配图
// */
//@property (nonatomic, strong) UIImage *curImage;
/**
 *  当前日记的配图
 */
@property (nonatomic, strong) NSMutableArray *curImages;

@end
