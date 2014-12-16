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
#import "UIView+Extension.h"
#import "Common.h"
#import "SNNoteModel.h"
#import "SNEditViewController.h"
#import "SNNoteTool.h"


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
 *  编辑日记按钮
 */
- (IBAction)editNoteBtn;

@end

@implementation SNNoteViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addData];
    
    [self setNoteBlock];
    
}


- (void)setNoteBlock {
    __weak typeof(self) weakSelf = self;
    self.editNote = ^(SNNoteModel *newNote){
        [weakSelf.notes replaceObjectAtIndex:weakSelf.index withObject:newNote];
        [SNNoteTool save:weakSelf.notes];
        if (weakSelf.index == 0) {
            weakSelf.firstNoteView.note = newNote;
        } else if (weakSelf.index == weakSelf.notes.count - 1) {
            weakSelf.thirdNoteView.note = newNote;
        } else {
            weakSelf.secondNoteView.note = newNote;
        }
    };
    
    self.deleteNote = ^(int curIndex){
        [weakSelf.notes removeObjectAtIndex:curIndex];
        [SNNoteTool save:weakSelf.notes];
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 刷新滚动页的偏移量(如果不是第一页和最后一页, 始终偏移至中间页面)
    if (self.index == 0) {
        return;
    }
    else if (self.index == 1 && self.notes.count == 2) {
        self.scrollView.contentOffset = CGPointMake(SCScreenWidth, 0);
    }
    else if (self.index == self.notes.count - 1) {
        self.scrollView.contentOffset = CGPointMake(SCScreenWidth * 2, 0);
        return;
    }
    else self.scrollView.contentOffset = CGPointMake(SCScreenWidth, 0);
    
}


#pragma mark - 加载数据
- (void)addData {
    /**
     *  动态加载数据
     *  显示第一页时,从第0个数据开始往后加载
     *  显示最后一页时,从最后一个数据往前加载
     *  显示其他页时,以当前数据往前和往后各分别加载
     */
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
- (void)updateData:(int)curPageState {
    if (self.notes.count > 2) {
        self.firstNoteView.note = self.notes[self.index - curPageState];
        self.secondNoteView.note = self.notes[self.index - curPageState + 1];
        self.thirdNoteView.note = self.notes[self.index - curPageState + 2];
    } else if (self.notes.count == 2 && self.index == 0) {
        self.firstNoteView.note = self.notes[self.index - curPageState];
        self.secondNoteView.note = self.notes[self.index - curPageState + 1];
    } else if (self.notes.count == 2 && self.index == 1) {
        self.firstNoteView.note = self.notes[self.index - curPageState + 1];
        self.secondNoteView.note = self.notes[self.index - curPageState + 2];
    } else if (self.notes.count == 1) {
        self.firstNoteView.note = self.notes[self.index - curPageState];
    }
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
- (void)clickToTurnPage:(int)curPageState {
    
    self.scrollView.contentOffset = CGPointMake(SCScreenWidth * curPageState, 0);
    
    [self loopDisplay:curPageState];
}

#pragma mark - 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offSetH = self.scrollView.contentOffset.x; // x轴偏移量
    int curPageState = offSetH / SCScreenWidth; // 翻页状态下标: 0 or 1 or 2

    NSLog(@"%zd", curPageState);
    // 循环显示数据源
    [self loopDisplay:curPageState];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.notes.count == 1) {
        self.scrollView.contentSize = CGSizeMake(SCScreenWidth, SCScreenHeight);
        return;
    }
    if (self.notes.count == 2) {
        self.scrollView.contentSize = CGSizeMake(SCScreenWidth * 2, SCScreenHeight);
    }
    CGFloat offsetH = self.scrollView.contentOffset.x - SCScreenWidth;
    // 翻页动画效果
    if (offsetH > 0) { // 翻至下一页
        self.thirdNoteLeadingCons.constant = - (SCScreenWidth * 0.5) + offsetH * 0.5;
        // 刷新图片数据
    } else if (offsetH < 0) { // 翻至上一页
        self.secondNoteLeadingCons.constant = offsetH * 0.5;
        // 刷新图片数据
    }
    
    // 阴影动画效果
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
    else if (pageState == 2 && self.index == self.notes.count - 2) {
        self.secondScrollView.contentOffset = CGPointMake(0, 0); // 当前页复位
        self.index++;
        return;
    }
    // 从后往前翻至第一页时, 模型下标减一, 不更新数据
    else if (pageState == 0 && self.index == 1) {
        self.secondScrollView.contentOffset = CGPointMake(0, 0); // 当前页复位
        self.index--;
        self.secondNoteLeadingCons.constant = 0; // 复位初始约束
        return;
    }
//    // 从第一篇进来后, 越过第二页, 直接翻至第三页, 更新数据
//    else if (pageState == 2 && self.index == 0) {
//        self.firstScrollView.contentOffset = CGPointMake(0, 0); // 第一页复位
//        self.index = self.index + 2;
//        
//        return;
//    }
//    // 从最后一篇进来后, 越过倒数第二页, 直接翻至倒数第三页, 更新数据
//    else if (pageState == 0 && self.index == self.notes.count - 1) {
//        self.thirdScrollView.contentOffset = CGPointMake(0, 0); // 最后一页复位
//        self.index = self.index - 2;
//        
//        return;;
//    }
    // 往后翻或往前翻, 模型下标加一或减一, 更新数据, (图片只更新上一页或下一页)
    else {
        if (pageState == 2 && self.index == 0) {
            NSLog(@"ok");
            self.firstScrollView.contentOffset = CGPointMake(0, 0); // 第一页复位
            self.index = self.index + 2;
        } else if (pageState == 0 && self.index == self.notes.count - 1) {
            self.thirdScrollView.contentOffset = CGPointMake(0, 0); // 最后一页复位
            self.index = self.index - 2;
            self.secondNoteLeadingCons.constant = 0; // 复位初始约束
            self.thirdNoteLeadingCons.constant = 0; // 复位初始约束
        } else {
            self.secondScrollView.contentOffset = CGPointMake(0, 0); // 中间页复位
            pageState == 0 ? self.index-- : self.index++;
            if (pageState == 0) self.secondNoteLeadingCons.constant = 0; // 复位初始约束
        }
        
        // 重复利用图片, 每次翻页只更新一个视图
        if (pageState == 0) {
            self.thirdNoteView.curImages = nil;
            self.thirdNoteView.curImages = self.secondNoteView.curImages;
            self.secondNoteView.curImages = self.firstNoteView.curImages;
            self.firstNoteView.curImages = nil;
        } else if (pageState == 2) {
            self.firstNoteView.curImages = nil;
            self.firstNoteView.curImages = self.secondNoteView.curImages;
            self.secondNoteView.curImages = self.thirdNoteView.curImages;
            self.thirdNoteView.curImages = nil;
        }

        self.firstNoteView.note = self.notes[self.index - 1];
        self.secondNoteView.note = self.notes[self.index];
        self.thirdNoteView.note = self.notes[self.index + 1];        
    }
}

- (IBAction)editNoteBtn {
    UIStoryboard *editSb = [UIStoryboard storyboardWithName:@"SNEditViewController" bundle:nil];
    SNEditViewController *editNc = [editSb instantiateInitialViewController];
    SNEditViewController *editVc = editNc.childViewControllers[0];
    editVc.curNote = self.notes[self.index];
    editVc.curIndex = self.index;
    if (self.index == 0) {
        editVc.curImages = self.firstNoteView.curImages;
    } else if (self.index == self.notes.count - 1) {
        editVc.curImages = self.thirdNoteView.curImages;
    } else {
        editVc.curImages = self.secondNoteView.curImages;
    }
    [self presentViewController:editNc animated:YES completion:nil];
    [editNc.childViewControllers[0] setNoteVc:self];
}
@end
