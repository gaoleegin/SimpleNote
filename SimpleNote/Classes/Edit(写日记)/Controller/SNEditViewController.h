//
//  SNEditViewController.h
//  SimpleNote
//
//  Created by Jason on 14/12/10.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNListViewController, SNNoteModel, SNNoteViewController;

@interface SNEditViewController : UIViewController

@property (nonatomic, strong) SNListViewController *listVc;

@property (nonatomic, strong) SNNoteViewController *noteVc;

@property (nonatomic, strong) SNNoteModel *curNote;

@property (nonatomic, strong) NSMutableArray *curImages;

@property (nonatomic, assign) int curIndex;

@end
