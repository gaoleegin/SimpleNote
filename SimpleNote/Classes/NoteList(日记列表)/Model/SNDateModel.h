//
//  SNNoteModel.h
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNDateModel : NSObject

@property (nonatomic, copy) NSString *date;

+ (instancetype)dateWithDict:(NSDictionary *)dict;
@end
