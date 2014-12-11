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
#import "SNDateModel.h"
#import "UIView+tools.h"
#import "Common.h"
#import "SNEditViewController.h"

@interface SNListViewController ()<UITableViewDataSource, UITableViewDelegate>

- (IBAction)back;

@property (nonatomic, strong) NSMutableArray *dates;

- (IBAction)showEditView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SNListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载数据
    NSArray *dateArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"date" ofType:@"plist"]];
    for (NSDictionary *dict in dateArr) {
        SNDateModel *dateM = [SNDateModel dateWithDict:dict];
        [self.notes addObject:dateM];
    }
    __weak typeof(self) weakSelf = self;
    self.saveNote = ^(NSString *body){
        NSDictionary *dateDict = @{@"date":body};
        SNDateModel *date = [SNDateModel dateWithDict:dateDict];
        [weakSelf.dates addObject:date];
        [weakSelf.tableView reloadData];
    };
}

#pragma mark - 懒加载
- (NSMutableArray *)notes {
    if (!_dates) {
        _dates = [NSMutableArray array];
    }
    return _dates;
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
