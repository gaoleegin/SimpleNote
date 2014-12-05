//
//  SNNoteModel.m
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNNoteModel.h"

@implementation SNNoteModel

+ (instancetype)noteWithDate:(NSString *)date bodyText:(NSString *)bodyText {
    SNNoteModel *note = [[self alloc] init];
    note.date = date;
    note.bodyText = bodyText;
    return note;
}

@end
