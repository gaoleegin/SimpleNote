//
//  SCSaveTool.m
//  JasonLottery-练习03
//
//  Created by Jason on 14/11/12.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#define SCUserDefaults [NSUserDefaults standardUserDefaults]

#import "SCSaveTool.h"

@implementation SCSaveTool

+ (id)objectForKey:(NSString *)defaultName
{
    return [SCUserDefaults objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName
{
    
    // 保存最新的版本
    [SCUserDefaults setObject:value forKey:defaultName];
    
    // 同步
    [SCUserDefaults synchronize];
}

@end
