//
//  MainNaviggationController.m
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//  LoveMage
//

#import "MainNaviggationController.h"

@interface MainNaviggationController ()

@end

@implementation MainNaviggationController


+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //导航栏为红色
    navBar.barTintColor = [UIColor redColor];
    
    navBar.translucent = NO;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
