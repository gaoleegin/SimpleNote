//
//  SNListViewCell.h
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNNoteModel;

@interface SNListViewCell : UITableViewCell

@property (nonatomic, strong) SNNoteModel *note;

@end
