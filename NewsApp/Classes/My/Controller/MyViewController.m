//
//  MyViewController.m
//  NewsApp
//
//  Created by qingyun on 16/8/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//  LoveMage
//

#import "MyViewController.h"

#define STATE @"state"//状态

@interface MyViewController ()
//文件保存的路径
@property (strong,nonatomic) NSString *filePath;

@end

@implementation MyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  loadDataFromLocation];
    // Do any additional setup after loading the view.
}


- (IBAction)SwithBtn:(UISwitch *)sender {
    
    if ([self saveDataToLocation]) {
        NSLog(@"数据保存成功");
    }
        //控制夜间模式
        if (sender.isOn) {
            self.tabBarController.view.alpha = 0.5;
        }else{
            self.tabBarController.view.alpha = 1;
        }
}
//将数据保存到磁盘的plist文件当中
-(BOOL) saveDataToLocation{
    //1.获取NSuserDefaults对象,单例的对象
    NSUserDefaults *userDefaults= [NSUserDefaults standardUserDefaults];
    //2.在对象中设置值,key-value 存储
    [userDefaults setBool:_nightModeBtn.on forKey:STATE];
    return [userDefaults synchronize];//将数据保存到磁盘中,
}
//读取plist文件
-(void) loadDataFromLocation{
    //NSUserDefaults 保存或者读取的操作 本质上是plist文件的操作,我们不需要通过文件名来读写
    //1.获取NSUserDefaults单例的对象  UserDefaults:(用户默认值)
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //读取状态
    _nightModeBtn.on = [userDefaults boolForKey:STATE];
    //控制夜间模式
    if (_nightModeBtn.on) {
        self.tabBarController.view.alpha = 0.5;
    }else{
        self.tabBarController.view.alpha = 1;
    }
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
