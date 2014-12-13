//
//  SNImageTool.m
//  SimpleNote
//
//  Created by Jason on 14/12/13.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//
// 日记图片完整路径

//stringByAppendingPathComponent:@"note.data"

#import "SNImageTool.h"

@implementation SNImageTool

+ (void)save:(UIImage *)image imagePath:(NSString *)imagePath {
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
}

//+ (NSString *)imagePath:(NSString *)imagePath {
//    return notes;
//}

@end
