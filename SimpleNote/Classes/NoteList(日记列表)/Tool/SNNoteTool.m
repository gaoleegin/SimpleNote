//
//  SNNoteTool.m
//  SimpleNote
//
//  Created by Jason on 14/12/12.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

// 日记数据完整路径
#define SNNotePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"note.data"]

#import "SNNoteTool.h"

@implementation SNNoteTool

+ (void)save:(NSMutableArray *)notes {
    [NSKeyedArchiver archiveRootObject:notes toFile:SNNotePath];
}

+ (NSMutableArray *)notes {
    NSMutableArray *notes = [NSKeyedUnarchiver unarchiveObjectWithFile:SNNotePath];
    return notes;
}

@end
