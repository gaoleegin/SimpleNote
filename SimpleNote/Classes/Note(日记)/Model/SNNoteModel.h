//
//  SNNoteModel.h
//  SimpleNote
//
//  Created by Jason on 14/12/8.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNNoteModel : NSObject
/**
 *  日期
 */
@property (nonatomic, copy) NSString *date;
/**
 *  正文
 */
@property (nonatomic, copy) NSString *body;

/**
 *  <初始化方法>从字典加载属性
 *
 *  @param dict 包含日期和正文属性的字典
 *
 *  @return 日记模型
 */
+ (instancetype)noteWithDict:(NSDictionary *)dict;

@end
