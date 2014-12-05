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

@interface SNNoteViewController ()

- (IBAction)back;

@property (strong, nonatomic) IBOutlet SNNoteView *noteView;
@end

@implementation SNNoteViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.noteView.note = self.note;
    NSLog(@"%@", [[UIApplication sharedApplication] keyWindow].subviews);
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
