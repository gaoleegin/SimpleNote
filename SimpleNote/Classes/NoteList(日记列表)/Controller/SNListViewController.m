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

@interface SNListViewController ()<UITableViewDataSource, UITableViewDelegate>

- (IBAction)back;

@property (nonatomic, strong) NSMutableArray *notes;
@end

@implementation SNListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SNNoteModel *note1 = [SNNoteModel noteWithDate:@"August 19th" bodyText:@"19号的日记"];
    SNNoteModel *note2 = [SNNoteModel noteWithDate:@"August 20th" bodyText:@"20号的日记"];
    SNNoteModel *note3 = [SNNoteModel noteWithDate:@"August 21th" bodyText:@"21号的日记"];
    SNNoteModel *note4 = [SNNoteModel noteWithDate:@"August 22th" bodyText:@"22号的日记"];
    [self.notes addObjectsFromArray:@[note1, note2, note3, note4]];
}

#pragma mark - 懒加载
- (NSMutableArray *)notes {
    if (!_notes) {
        _notes = [NSMutableArray array];
    }
    return _notes;
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
    
    SNNoteViewController *preVc = [[SNNoteViewController alloc] init];
    SNNoteViewController *nextVc = [[SNNoteViewController alloc] init];
    preVc.view.x = SCScreenWidth * (-1);
    nextVc.view.x = SCScreenWidth * 0.5;
    
    [SCKeyWindow addSubview:preVc.view];
    [SCKeyWindow addSubview:nextVc.view];

    // cell选中后恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SNNoteViewController *noteVc = segue.destinationViewController;
    noteVc.index = [sender row];
    noteVc.note = self.notes[noteVc.index];
}

- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
