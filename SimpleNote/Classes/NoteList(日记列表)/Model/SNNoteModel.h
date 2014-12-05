//
//  SNNoteModel.h
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNNoteModel : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *bodyText;

+ (instancetype)noteWithDate:(NSString *)date
                    bodyText:(NSString *)bodyText;
@end
