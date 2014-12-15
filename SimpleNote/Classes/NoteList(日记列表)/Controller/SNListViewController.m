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
#import "Common.h"
#import "SNEditViewController.h"
#import "SNNoteTool.h"
#import "MJExtension.h"

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
    // 从沙盒读取数据
    _notes = [SNNoteTool notes];
    
    if (!_notes) {
        // 从mainBundle加载默认数据
        NSMutableArray *dictArr = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"note" ofType:@"plist"]];
        self.dictArr = dictArr;
        for (NSDictionary *dict in dictArr) {
            SNNoteModel *noteM = [SNNoteModel objectWithKeyValues:dict];
            [self.notes addObject:noteM];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    self.saveNote = ^(SNNoteModel *newNote){
        [weakSelf.notes insertObject:newNote atIndex:0];
        [SNNoteTool save:weakSelf.notes];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
        });
    };
}
//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
//});


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
