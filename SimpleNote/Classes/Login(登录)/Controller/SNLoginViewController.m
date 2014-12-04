//
//  SNLoginViewController.m
//  SimpleNote
//
//  Created by Jason on 14/12/4.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNLoginViewController.h"

@interface SNLoginViewController ()

- (IBAction)login;

@end

@implementation SNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation
- (IBAction)login {
    [self performSegueWithIdentifier:@"login2List" sender:nil];
}
@end
