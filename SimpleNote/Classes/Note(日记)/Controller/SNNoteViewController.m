//
//  SNNoteViewController.m
//  SimpleNote
//
//  Created by Jason on 14/12/4.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNNoteViewController.h"
#import "SNNoteModel.h"
#import "SNNoteView.h"
#import "UIView+tools.h"
#import "Common.h"
#import "SNNoteModel.h"


#define SNSHADOW_ALPHA 0.6 //页尾阴影透明度
#define SNSHADOW_ANIMATION_RANGE 0.1 //页尾阴影动画范围

@interface SNNoteViewController ()<UIScrollViewDelegate>
/**
 *  返回日记列表控制器
 */
- (IBAction)back;
/**
 *  翻页至上一页按钮
 */
- (IBAction)preNote;
/**
 *  翻页至下一页按钮
 */
- (IBAction)nextNote;
/**
 *  保存模拟数据
 */
@property (nonatomic, strong) NSMutableArray *notes;
/**
 *  滚动视图, 用来监听偏移量
 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**
 *  上一页
 */
@property (strong, nonatomic) IBOutlet SNNoteView *firstNoteView;
/**
 *  当前页
 */
@property (weak, nonatomic) IBOutlet SNNoteView *secondNoteView;
/**
 *  下一页
 */
@property (weak, nonatomic) IBOutlet SNNoteView *thirdNoteView;
/**
 *  当前页leading等于上一页trailing的距离约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondNoteLeadingCons;
/**
 *  下一页leading等于当前页trailing的距离约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdNoteLeadingCons;
/**
 *  上一页滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *firstScrollView;
/**
 *  当前页滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *secondScrollView;
/**
 *  下一页滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *thirdScrollView;
/**
 *  上一页的页尾阴影
 */
@property (weak, nonatomic) IBOutlet UIImageView *firstNoteShadow;
/**
 *  当前页的页尾阴影
 */
@property (weak, nonatomic) IBOutlet UIImageView *secondNoteShadow;
/**
 *  首页的左边箭头按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *leftArrowBtn;
/**
 *  首页的右边箭头按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *rightArrowBtn;

@end

@implementation SNNoteViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 判断内容页的偏移量
    if (self.index == 0) return;
    else if (self.index == self.notes.count - 1) {
        self.scrollView.contentOffset = CGPointMake(SCScreenWidth * 2, 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(SCScreenWidth, 0);
    }
    
    // 翻至第一页或最后一页时, 隐藏箭头按钮
    if (self.index == 0 || self.index == 1) {
        self.leftArrowBtn.hidden = YES;
    } else if (self.index == self.notes.count - 1 || self.index == self.notes.count - 2) {
        self.rightArrowBtn.hidden = YES;
    } else {
        self.leftArrowBtn.hidden = NO;
        self.rightArrowBtn.hidden = NO;
    }
}


#pragma mark - 加载数据
- (void)addData {
    NSArray *noteArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"note" ofType:@"plist"]];
    for (NSDictionary *dict in noteArr) {
        SNNoteModel *noteM = [SNNoteModel noteWithDict:dict];
        [self.notes addObject:noteM];
    }
    
    // 动态加载数据(从其他页载入/从第一页载入/从最后一页载入)
    if (self.index > 0 && self.index < self.notes.count - 1) {
        [self updateData:1];
    } else if (self.index == 0) {
        [self updateData:0];
    } else if (self.index == self.notes.count - 1) {
        [self updateData:2];
    }
}

#pragma mark <更新数据公共方法>
/**
 *  动态更新数据
 *
 *  @param curPage 0:当前显示第一页 / 1:当前显示其他页 / 2:当前显示最后一页
 */
- (void)updateData:(int)curPage {
    self.firstNoteView.note = self.notes[self.index - curPage];
    self.secondNoteView.note = self.notes[self.index - curPage + 1];
    self.thirdNoteView.note = self.notes[self.index - curPage + 2];
}

#pragma mark - 懒加载属性
- (NSMutableArray *)notes {
    if (!_notes) {
        _notes = [NSMutableArray array];
    }
    return _notes;
}

#pragma mark - 监听事件
- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)preNote {
    self.index == self.notes.count - 1 ? [self clickToTurnPage:1] : [self clickToTurnPage:0];
}

- (IBAction)nextNote {
    self.index == 0 ? [self clickToTurnPage:1] : [self clickToTurnPage:2];
}

#pragma mark <监听事件公共方法>
- (void)clickToTurnPage:(int)coefficient {
    
    self.scrollView.contentOffset = CGPointMake(SCScreenWidth * coefficient, 0);
    
    [self loopDisplay:coefficient];
}

#pragma mark - 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offSetH = self.scrollView.contentOffset.x; // x轴偏移量
    int pageState = offSetH / SCScreenWidth; // 翻页状态下标: 0 or 1 or 2
    
    // 循环显示数据源
    [self loopDisplay:pageState];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetH = self.scrollView.contentOffset.x - SCScreenWidth;

    if (offsetH < 0) {
        self.secondNoteLeadingCons.constant = offsetH * 0.5;
    } else if (offsetH > 0) {
        self.thirdNoteLeadingCons.constant = - (SCScreenWidth * 0.5) + offsetH * 0.5;
    }
    
    if (offsetH > 0) { // 下一页
        self.thirdNoteLeadingCons.constant = -(SCScreenWidth * 0.5) + offsetH * 0.5;
    } else if (offsetH < 0) { // 上一页
        self.secondNoteLeadingCons.constant = offsetH * 0.5;
    }
    
    // 阴影逻辑实现
    CGFloat alpha_st = (- offsetH) / (SCScreenWidth * SNSHADOW_ANIMATION_RANGE);
    if (alpha_st > SNSHADOW_ALPHA) alpha_st = SNSHADOW_ALPHA;
    self.firstNoteShadow.alpha = alpha_st;
    
    CGFloat alpha_nd = (SCScreenWidth - offsetH) / (SCScreenWidth * SNSHADOW_ANIMATION_RANGE);
    if (alpha_nd > SNSHADOW_ALPHA) alpha_nd = SNSHADOW_ALPHA;
    self.secondNoteShadow.alpha = alpha_nd;
}

#pragma mark <更新数据>
- (void)loopDisplay:(int)pageState {
    // 从第一篇进来后, 翻至第二页时, 模型下标加一 ,不更新数据
    if (pageState == 1 && self.index == 0) {
        self.firstScrollView.contentOffset = CGPointMake(0, 0); // 上一页复位
        self.index++;
        return;
    }
    // 从最后一篇进来后, 翻至倒数第二页时, 模型下标减一, 不更新数据
    else if (pageState == 1 && self.index == self.notes.count - 1) {
        self.thirdScrollView.contentOffset = CGPointMake(0, 0); // 下一页复位
        self.index--;
        return;
    }
    // 翻页状态不变时, 不更新数据
    else if (pageState == 1 || (pageState == 0 && self.index == 0) || (pageState == 2 && self.index == self.notes.count - 1)) return;
    
    // 从前往后翻至最后一页时, 模型下标加一, 不更新数据
    else if (pageState == 2 && self.index == self.notes.count - 2) {self.index++;return;}
    // 从后往前翻至第一页时, 模型下标减一, 不更新数据
    else if (pageState == 0 && self.index == 1) {
        self.index--;
        self.secondNoteLeadingCons.constant = 0; // 复位初始约束
        return;
    }
    // 往后翻或往前翻, 模型下标加一或减一, 更新数据
    else {
        self.secondScrollView.contentOffset = CGPointMake(0, 0); // 当前页复位
        pageState == 0 ? self.index-- : self.index++;
        if (pageState == 0) self.secondNoteLeadingCons.constant = 0; // 复位初始约束
        
        self.firstNoteView.note = self.notes[self.index - 1];
        self.secondNoteView.note = self.notes[self.index];
        self.thirdNoteView.note = self.notes[self.index + 1];
    }
}

@end
