//
//  SNNoteViewController.h
//  SimpleNote
//
//  Created by Jason on 14/12/4.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNNoteModel;

@interface SNNoteViewController : UIViewController

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) SNNoteModel *note;

@end
