//
//  MBProgressHUD+Extend.h
//  RACIaskulogin
//
//  Created by 孟辉 on 16/6/13.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extend)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
