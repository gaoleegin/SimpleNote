//
//  SNNoteModel.m
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNDateModel.h"

@implementation SNDateModel

+ (instancetype)dateWithDict:(NSDictionary *)dict {
    SNDateModel *dateM = [[self alloc] init];
    [dateM setValuesForKeysWithDictionary:dict];
    return dateM;
}

@end
