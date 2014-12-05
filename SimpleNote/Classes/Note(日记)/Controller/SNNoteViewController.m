//
//  SNNoteViewController.m
//  SimpleNote
//
//  Created by Jason on 14/12/4.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNNoteViewController.h"

@interface SNNoteViewController ()

- (IBAction)back;

@property (nonatomic, weak) IBOutlet UILabel *bodyLabel;

@end

@implementation SNNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bodyLabel.text = [NSString stringWithFormat:@"安师大哈接收到就爱看是大街上大事件还打算科技活动啊手机卡大劫案斯柯达卡仕达啊接收到卡接收到安师大哈接收到就爱看是大仕达啊接收到卡接收到安师大哈接收到就爱看是大街上动啊手机卡大劫案收收到卡件还打算科技大劫案收收到卡接收到"];
    
    SNNoteViewController *preVc = [[SNNoteViewController alloc] init];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
