//
//  SNNoteModel.h
//  SimpleNote
//
//  Created by Jason on 14/12/8.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNNoteModel : NSObject<NSCoding>
/**
 *  日期
 */
@property (nonatomic, copy) NSString *date;
/**
 *  正文
 */
@property (nonatomic, copy) NSString *body;
///**
// *  配图名
// */
//@property (nonatomic, copy) NSString *imageName;
/**
 *  配图名数组
 */
@property (nonatomic, strong) NSMutableArray *imageNames;


@end
