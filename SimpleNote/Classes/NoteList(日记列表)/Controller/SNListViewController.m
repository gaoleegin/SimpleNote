//
//  SNListViewController.m
//  SimpleNote
//
//  Created by Jason on 14/12/4.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNListViewController.h"
#import "SNNoteViewController.h"
#import "SNListViewCell.h"
#import "SNNoteModel.h"
#import "UIView+tools.h"
#import "Common.h"
#import "SNEditViewController.h"

@interface SNListViewController ()<UITableViewDataSource, UITableViewDelegate>

- (IBAction)back;

@property (nonatomic, strong) NSMutableArray *notes;

@property (nonatomic, strong) NSMutableArray *dictArr;

- (IBAction)showEditView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SNListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 判断用户是否第一次加载
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [document stringByAppendingPathComponent:@"note.plist"];
    NSMutableArray *dictArr = [NSMutableArray arrayWithContentsOfFile:path];
    if (!dictArr) {
        // 从mainBundle加载默认数据
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"note" ofType:@"plist"]];
        for (NSDictionary *dict in dictArr) {
            SNNoteModel *noteM = [SNNoteModel noteWithDict:dict];
            [self.notes addObject:noteM];
        }
    } else {
        // 加载用户自己的数据
        self.dictArr = dictArr;
        for (NSDictionary *dict in dictArr) {
            SNNoteModel *noteM = [SNNoteModel noteWithDict:dict];
            [self.notes addObject:noteM];
            NSLog(@"%@", self.notes );
        }
    }
    __weak typeof(self) weakSelf = self;
    self.saveNote = ^(NSDictionary *noteDict){
        // 存储新日记数据至沙盒
        [weakSelf.dictArr insertObject:noteDict atIndex:0];
        [weakSelf.dictArr writeToFile:path atomically:YES];
        // 转新日记字典为模型, 刷新显示
        SNNoteModel *noteM = [SNNoteModel noteWithDict:noteDict];
        [weakSelf.notes insertObject:noteM atIndex:0];
        [UIView animateWithDuration:1 animations:^{
            weakSelf.tableView.contentOffset = CGPointMake(0, 0); // 复位
        }];
        [weakSelf.tableView reloadData];
    };
}

#pragma mark - 懒加载
- (NSMutableArray *)notes {
    if (!_notes) {
        _notes = [NSMutableArray array];
    }
    return _notes;
}

- (NSMutableArray *)dictArr {
    if (!_dictArr) {
        _dictArr = [NSMutableArray array];
    }
    return _dictArr;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = (indexPath.row % 2) == 0 ? @"Cell1" : @"Cell2";
    
    SNListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.note = self.notes[indexPath.row];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"list2Note" sender:indexPath];
        
    // 选中后恢复cell状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SNNoteViewController *noteVc = segue.destinationViewController;
    NSIndexPath *indexPath = sender;
    noteVc.index = (int)indexPath.row;
    noteVc.notes = self.notes;
}


- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showEditView {
    UIStoryboard *editSb = [UIStoryboard storyboardWithName:@"SNEditViewController" bundle:nil];
    SNEditViewController *editNc = [editSb instantiateInitialViewController];
    [self presentViewController:editNc animated:YES completion:nil];
    [editNc.childViewControllers[0] setListVc:self];
}

@end
