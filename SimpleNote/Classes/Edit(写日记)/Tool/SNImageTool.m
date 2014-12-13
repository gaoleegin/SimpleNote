//
//  SNImageTool.m
//  SimpleNote
//
//  Created by Jason on 14/12/13.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//
// 日记图片完整路径

#define SNImagePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#import "SNImageTool.h"

@implementation SNImageTool

+ (void)save:(UIImage *)image imageName:(NSString *)imageName {
    NSString *imagePath = [SNImagePath stringByAppendingPathComponent:imageName];
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
}

+ (NSString *)imagePath:(NSString *)imageName {
    NSLog(@"%@",[SNImagePath stringByAppendingString:imageName]);
    return [SNImagePath stringByAppendingPathComponent:imageName];
}

@end
