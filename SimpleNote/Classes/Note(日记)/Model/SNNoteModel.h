//
//  SNNoteModel.h
//  SimpleNote
//
//  Created by Jason on 14/12/8.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNNoteModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *body;

+ (instancetype)noteWithDict:(NSDictionary *)dict;

@end
