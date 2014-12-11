//
//  SNListViewController.h
//  SimpleNote
//
//  Created by Jason on 14/12/4.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNNoteModel;

@interface SNListViewController : UIViewController

@property (nonatomic, copy) void(^saveNote)(SNNoteModel *body);

@end
