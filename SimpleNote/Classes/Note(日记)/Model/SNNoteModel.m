//
//  SNNoteModel.m
//  SimpleNote
//
//  Created by Jason on 14/12/8.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNNoteModel.h"

@implementation SNNoteModel

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.date = [decoder decodeObjectForKey:@"date"];
        self.body = [decoder decodeObjectForKey:@"body"];
        self.imageNames = [decoder decodeObjectForKey:@"imageNames"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.body forKey:@"body"];
    [encoder encodeObject:self.imageNames forKey:@"imageNames"];
}

@end
