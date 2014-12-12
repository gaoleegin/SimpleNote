//
//  SCGuideTool.m
//  JasonLottery-练习03
//
//  Created by Jason on 14/11/12.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#define GuideController JLGuideController
#define TabBarController JLTabBarController

#import "SCGuideTool.h"
#import "SCSaveTool.h"
#import "JLTabBarController.h"
#import "JLGuideController.h"

@implementation SCGuideTool

+ (void)chooseRootViewController:(UIWindow *)window {
    // 判断是否有新的版本
    // 获取当前用户手机的版本
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    NSString *curVersion = dict[@"CFBundleVersion"];
    // 获取之前存储版本
    NSString *lastVersion = [SCSaveTool objectForKey:@"version"];
    
    if ([curVersion isEqualToString:lastVersion]) { // 没有新版本
        // 设置根控制器为main
        JLTabBarController *tabBar = [[JLTabBarController alloc] init];
        
        window.rootViewController = tabBar;
    } else { // 有新版本
    
        // 储存最新版本
        [SCSaveTool setObject:curVersion forKey:@"version"];
    
        // 进入引导页面
        JLGuideController *guideVc = [[JLGuideController alloc] init];

        window.rootViewController = guideVc;
    }
}

@end
