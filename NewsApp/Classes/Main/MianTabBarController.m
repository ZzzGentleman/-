//
//  MianTabBarController.m
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//  LoveMage
//

#import "MianTabBarController.h"
#import "HomeViewController.h"
#import "HotViewController.h"
#import "MyViewController.h"
#import "MainNaviggationController.h"

@interface MianTabBarController ()
@property (nonatomic, copy) NSString *str;

@end

@implementation MianTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arrLibrary = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *strLibrary = [arrLibrary objectAtIndex:0];
    NSLog(@"Library路径%@",strLibrary);
    //取出info.plit文件保存的属性
    BOOL isState = [(NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"state"] boolValue];
    if (isState == 1) {
        self.view.alpha = 0.5;
    }else{
        self.view.alpha = 1;
    }
    
    /** 加载控制器 */
    [self loaDefaultViewController];
   
    // Do any additional setup after loading the view.
}
/** 加载控制器 */
-(void)loaDefaultViewController{

    //创建首页的控制器
    HomeViewController *vcHome = [[HomeViewController alloc] init];
    [self addViewCountroller:vcHome imageName:@"首页" title:@"首页"];
    //创建热门的控制器
    HotViewController *vcHot = [[HotViewController alloc] init];
    [self addViewCountroller:vcHot imageName:@"热门" title:@"热门"];
    //创建我的控制器
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyViewController" bundle:[NSBundle mainBundle]];
    MyViewController *vcMy = [[MyViewController alloc] init];
    vcMy = [storyboard instantiateViewControllerWithIdentifier:@"MyViewController"];
    [self addViewCountroller:vcMy imageName:@"我" title:@"我"];
    
    //设置图标，文字显示颜色
    self.tabBar.tintColor = [UIColor orangeColor];
   
}

-(void)addViewCountroller:(UIViewController *)viewController imageName:(NSString *)imageName title:(NSString *)title{
    //设置tabBarItem的图片
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    //设置tabBarItem的点击图片
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]];
    //设置控制器的title = 传过来的title
    viewController.title = title;
    //设置tabBarItem标题的位置调整
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 0);
    //创建一个导航控制器
     MainNaviggationController *vcNavigation = [[MainNaviggationController alloc] initWithRootViewController:viewController];
    //把导航控制器添加到TanBarController中
    [self addChildViewController:vcNavigation];
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
