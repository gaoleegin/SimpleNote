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

@interface SNNoteViewController ()<UIScrollViewDelegate>

- (IBAction)back;

- (IBAction)preNote;

- (IBAction)nextNote;

@property (nonatomic, strong) NSMutableArray *notes;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet SNNoteView *firstNoteView;

@property (weak, nonatomic) IBOutlet SNNoteView *secondNoteView;

@property (weak, nonatomic) IBOutlet SNNoteView *thirdNoteView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondNoteLeadingCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdNoteLeadingCons;

@property (weak, nonatomic) IBOutlet UIScrollView *secondScrollView;
@end

@implementation SNNoteViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载数据
    NSArray *noteArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"note" ofType:@"plist"]];
    for (NSDictionary *dict in noteArr) {
        SNNoteModel *noteM = [SNNoteModel noteWithDict:dict];
        [self.notes addObject:noteM];
    }
    // Do any additional setup after loading the view.
    if (self.index > 0 && self.index < self.notes.count - 1) {
        self.firstNoteView.note = self.notes[self.index - 1];
        self.secondNoteView.note = self.notes[self.index];
        self.thirdNoteView.note = self.notes[self.index + 1];
    } else if (self.index == 0) {
        self.firstNoteView.note = self.notes[self.index];
        self.secondNoteView.note = self.notes[self.index + 1];
        self.thirdNoteView.note = self.notes[self.index + 2];
        
    } else if (self.index == self.notes.count - 1) {
        self.firstNoteView.note = self.notes[self.index - 2];
        self.secondNoteView.note = self.notes[self.index - 1];
        self.thirdNoteView.note = self.notes[self.index];
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)notes {
    if (!_notes) {
        _notes = [NSMutableArray array];
    }
    return _notes;
}

- (void)viewDidLayoutSubviews {
    if (self.index == 0) return;
    if (self.index == self.notes.count - 1) {
        self.scrollView.contentOffset = CGPointMake(SCScreenWidth * 2, 0);
    } else {
    self.scrollView.contentOffset = CGPointMake(SCScreenWidth, 0);
    }
}


- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)preNote {
    self.index == (self.notes.count - 1) ? [self clickToTurnPage:1] : [self clickToTurnPage:0];
}

- (IBAction)nextNote {
    self.index == 0 ? [self clickToTurnPage:1] : [self clickToTurnPage:2];
}

- (void)clickToTurnPage:(int)coefficient {
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(SCScreenWidth * coefficient, 0);
    }];
    [self scrollViewDidEndDecelerating:self.scrollView];
}

#pragma mark - 监听代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offSetH = self.scrollView.contentOffset.x;
    int pageState = offSetH / SCScreenWidth; // 翻页状态下标: 0 or 1 or 2
    
    // 设置数据源
    [self loopDisplay:pageState];
    
    self.firstNoteView.layer.shadowOpacity = 0.0;
    self.secondNoteView.layer.shadowOpacity = 0.0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetH = self.scrollView.contentOffset.x - SCScreenWidth;
    
    if (offsetH < 0) {
        self.secondNoteLeadingCons.constant = offsetH * 0.5;
    } else if (offsetH > 0) {
        self.thirdNoteLeadingCons.constant = offsetH * 0.5;
    }
    self.firstNoteView.layer.shadowOpacity = 0.2;
    self.secondNoteView.layer.shadowOpacity = 0.2;
}

- (void)loopDisplay:(int)pageState {
    // 复位初始约束
    self.secondNoteLeadingCons.constant = 0;
    // 复位secondView初始状态
    self.secondScrollView.contentOffset = CGPointMake(0, 0);
    // 从第一篇进来后, 翻至第二页时, 模型下标加一 ,不执行操作
    if (pageState == 1 && self.index == 0) {self.index++;return;}
    // 从最后一篇进来后, 翻至倒数第二页时, 模行下标减一, 不执行操作
    else if (pageState == 1 && self.index == self.notes.count - 1) {self.index--;return;}
    // 翻页状态不变时, 不执行操作
    else if (pageState == 1 || (pageState == 0 && self.index == 0) || (pageState == 2 && self.index == self.notes.count - 1)) return;
    
    // 翻至最后一页时, 不执行操作
    else if (pageState == 2 && self.index == self.notes.count - 2) {self.index++;return;}
    // 翻至第一页时, 不执行操作
    else if (pageState == 0 && self.index == 1) {self.index--;return;}
    // 往前翻或往后翻, 模型下标自加或自减
    else {
        pageState == 2 ? self.index++ : self.index--;
        self.scrollView.contentOffset = CGPointMake(SCScreenWidth, 0);
        self.firstNoteView.note = self.notes[self.index - 1];
        self.secondNoteView.note = self.notes[self.index];
        self.thirdNoteView.note = self.notes[self.index + 1];
    }
}

@end
