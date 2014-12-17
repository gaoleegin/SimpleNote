//
//  SNLoginViewController.m
//  SimpleNote
//
//  Created by Jason on 14/12/4.
//  Copyright (c) 2014年 Jason’s Application House. All rights reserved.
//

#import "SNLoginViewController.h"
#import "Common.h"
#import <LocalAuthentication/LocalAuthentication.h>


@interface SNLoginViewController ()<UIAlertViewDelegate>

@property (nonatomic, weak) UIAlertView *alert;

@end

@implementation SNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self login];
}

- (void)login {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"登录" otherButtonTitles:nil, nil];
    self.alert = alert;
    
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    context.localizedFallbackTitle = @"输入密码";
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"使用指纹登录", nil) reply:^(BOOL success, NSError *error) {
            if (success) {
                [self performSegueWithIdentifier:@"login2List" sender:nil];
            } else {
                alert.title = @"提示";
                
                switch (error.code) {
                    case LAErrorUserCancel:
                        alert.message = @"验证取消, 直接点击登录您的个人日记";
                        break;
                        
                    case LAErrorAuthenticationFailed:
                        alert.message = @"验证失败";
                        break;
                        
                    case LAErrorPasscodeNotSet:
                        alert.message = @"未设密码";
                        break;
                        
                    case LAErrorSystemCancel:
                        alert.message = @"系统取消了你的验证";
                        break;
                        
                    case LAErrorUserFallback:
                        alert.message = @"没有密码模块, 直接点击登录您的个人日记";
                        break;
                        
                    default:
                        alert.message = @"未能成功使用指纹登录";
                        break;
                }
                [alert show];
            }
        }];
    } else {
        alert.title = @"提示";
        
        if(error.code == LAErrorTouchIDNotEnrolled) {
            alert.message = @"你没有登记任何指纹, 直接点击登录您的个人日记";
        }else if(error.code == LAErrorTouchIDNotAvailable) {
            alert.message = @"您的手机不支持TouchID, 直接点击登录您的个人日记";
        }else if(error.code == LAErrorPasscodeNotSet){
            alert.message = @"你没有设置你的密码, 直接点击登录您的个人日记";
        }
        
        [alert show];
    }
}



#pragma mark - Navigation

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"login2List" sender:nil];
    }
}
@end
