//
//  SNNoteView.m
//  SimpleNote
//
//  Created by Jason on 14/12/5.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNNoteView.h"
#import "SNBodyLabel.h"
#import "SNNoteModel.h"
#import "SCImageTool.h"
#import "Common.h"
#import "Masonry.h"
#import "SNImageView.h"

// 定义这个宏可以使用一些更简洁的方法
#define MAS_SHORTHAND

// 定义这个宏可以使用自动装箱功能
#define MAS_SHORTHAND_GLOBALS


@interface SNNoteView()
/**
 *  日期标签
 */
@property (weak, nonatomic) IBOutlet UILabel *date;
/**
 *  正文标签
 */
@property (weak, nonatomic) IBOutlet SNBodyLabel *textLabel;
/**
 *  图片容器内第一张图片
 */
@property (weak, nonatomic) IBOutlet SNImageView *imageView;
/**
 *  第一张图片高度约束
 */
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *imageViewHeightCons;
/**
 *  第一张图片距离第二张间隔约束
 */
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *imageView2ToimageViewMargin;
/**
 *  图片容器内第二张图片
 */
@property (weak, nonatomic) IBOutlet SNImageView *imageView2;
/**
 *  第二张图片高度约束
 */
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *imageViewHeightCons2;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *imageView3ToimageView2Margin;
/**
 *  图片容器内第三张图片
 */
@property (weak, nonatomic) IBOutlet SNImageView *imageView3;
/**
 *  第三张图片高度约束
 */
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *imageViewHeightCons3;

/**
 *  并发队列
 */
@property (nonatomic, strong) NSOperationQueue *opQueue;

@end

@implementation SNNoteView

#pragma mark - 懒加载
- (NSMutableArray *)curImages {
    if (!_curImages) {
        _curImages = [NSMutableArray array];
    }
    return _curImages;
}

- (NSOperationQueue *)opQueue {
    if (_opQueue == nil) {
        _opQueue = [[NSOperationQueue alloc] init];
    }
    return _opQueue;
}


/**
 *  更新UI数据
 *
 *  @param note 日记模型
 */
- (void)setNote:(SNNoteModel *)note {
    _note = note;
    self.date.text = note.date;
    self.textLabel.text = note.body;
    
    if (note.imageNames.count != 0) { // 如果该页有配图
        if (self.curImages.count == 0) { // 如果该页是新页, (比如 1 2 3 跳转 2 3 4 , 4就是新页, 2,3是旧页, 旧页不需要去沙盒读取图片, 新页需要去沙盒读取图片)
            // 这里循环添加image, 先取出第一张配图,存进数组
            
            NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
                UIImage *image = [UIImage imageWithContentsOfFile:[SCImageTool imagePath:note.imageNames[0]]];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.curImages addObject:image];
                    self.imageView.image = image;
                    [self.imageView setNeedsLayout];
                }];
            }];
            [self.opQueue addOperation:op1];
            
            if (note.imageNames.count > 1) {
                NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
                    UIImage *image2 = [UIImage imageWithContentsOfFile:[SCImageTool imagePath:note.imageNames[1]]];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.curImages addObject:image2];
                        self.imageView2.image = image2;
                        [self.imageView2 setNeedsLayout];
                    }];
                }];
                self.imageView2ToimageViewMargin.constant = 40.0;
                [op2 addDependency:op1];
                [self.opQueue addOperation:op2];
                
                if (note.imageNames.count > 2) {
                    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
                        UIImage *image3 = [UIImage imageWithContentsOfFile:[SCImageTool imagePath:note.imageNames[2]]];;
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [self.curImages addObject:image3];
                            self.imageView3.image = image3;
                            [self.imageView3 setNeedsLayout];
                        }];
                    }];
                    self.imageView3ToimageView2Margin.constant = 40.0;
                    [op3 addDependency:op2];
                    [self.opQueue addOperation:op3];
                } else {
                    self.imageView3.image = nil;
                    self.imageView3ToimageView2Margin.constant = 0.0;
                }
                
            } else {
                self.imageView2.image = nil;
                self.imageView3.image = nil;
                self.imageView2ToimageViewMargin.constant = 0.0;
                self.imageView3ToimageView2Margin.constant = 0.0;
            }
            

            
//            [self.opQueue addOperations:@[op1, op2, op3] waitUntilFinished:YES];


            
            
            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self.imageView.image = image;
//                    [self.imageView setNeedsLayout];
//                });
//            });
            
//            if (note.imageNames.count > 1) {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        self.imageView2.image = image2;
//                        [self.imageView2 setNeedsLayout];
//                    });
//                });
//                self.imageView2ToimageViewMargin.constant = 40.0;
//            } else {
//                self.imageView2.image = nil;
//                self.imageView3.image = nil;
//                self.imageView2ToimageViewMargin.constant = 0.0;
//                self.imageView3ToimageView2Margin.constant = 0.0;
//            }
            
//            if (note.imageNames.count > 2) {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        self.imageView3.image = image3;
//                        [self.imageView3 setNeedsLayout];
//                    });
//                });
//                self.imageView3ToimageView2Margin.constant = 40.0;
//            } else {
//                self.imageView3.image = nil;
//                self.imageView3ToimageView2Margin.constant = 0.0;
//            }
//            
            
            
            
        } else { //如果该页是旧页, 直接赋值image
            // 这里循环添加数组中的image
            if (self.curImages.count > 0) {
                self.imageView.image = self.curImages[0];
            } else {
                self.imageView.image = nil;
                self.imageView2.image = nil;
                self.imageView3.image = nil;
                self.imageView2ToimageViewMargin.constant = 0.0;
                self.imageView3ToimageView2Margin.constant = 0.0;
            }
            if (self.curImages.count > 1) {
                self.imageView2.image = self.curImages[1];
                self.imageView2ToimageViewMargin.constant = 40.0;
            } else {
                self.imageView2.image = nil;
                self.imageView3.image = nil;
                self.imageView2ToimageViewMargin.constant = 0.0;
                self.imageView3ToimageView2Margin.constant = 0.0;
            }
            if (self.curImages.count > 2) {
                self.imageView3.image = self.curImages[2];
                self.imageView3ToimageView2Margin.constant = 40.0;
            } else {
                self.imageView3.image = nil;
                self.imageView3ToimageView2Margin.constant = 0.0;
            }
        }
        if (Iphone) { // 如果是iphone, 每张图的高设为280, 因为翻页时高度会更新成0
            if (self.imageView.image) {
                self.imageViewHeightCons.constant = 280;
            } else {
                self.imageViewHeightCons.constant = 0;
            }
            if (self.imageView2.image) {
                self.imageViewHeightCons2.constant = 280;
            } else {
                self.imageViewHeightCons2.constant = 0;
            }
            if (self.imageView3.image) {
                self.imageViewHeightCons3.constant = 280;
            } else {
                self.imageViewHeightCons3.constant = 0;
            }
        } else { // 如果是ipad, 高度为480
            if (self.imageView.image) {
                self.imageViewHeightCons.constant = 480;
            } else {
                self.imageViewHeightCons.constant = 0;
            }
            if (self.imageView2.image) {
                self.imageViewHeightCons2.constant = 480;
            } else {
                self.imageViewHeightCons2.constant = 0;
            }
            if (self.imageView3.image) {
                self.imageViewHeightCons3.constant = 480;
            } else {
                self.imageViewHeightCons3.constant = 0;
            }
        }
    } else { // 如果没有图片, 把高度清零
        self.imageView.image = nil;
        self.imageView2.image = nil;
        self.imageView3.image = nil;
        self.imageViewHeightCons.constant = 0;
        self.imageViewHeightCons2.constant = 0;
        self.imageViewHeightCons3.constant = 0;
    }
}

@end
