//
//  SNNoteModel.m
//  SimpleNote
//
//  Created by Jason on 14/12/8.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNNoteModel.h"

@implementation SNNoteModel

+ (instancetype)noteWithDict:(NSDictionary *)dict {
    SNNoteModel *noteM = [[SNNoteModel alloc] init];
    [noteM setValuesForKeysWithDictionary:dict];
    return noteM;
}

@end
