//
//  GuideViewController.m
//  魅力永城
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"
#import "Masonry.h"

@interface GuideViewController ()

//创建一个滚动视图
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDefaultSetting];
    // Do any additional setup after loading the view.
}

/** 加载默认设置和UI */
- (void)loadDefaultSetting {
    // 添加ScrollView
    UIScrollView *scrollView = [UIScrollView new];
    
    //把滚动视图添加到屏幕上
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    //设置全屏的ScrollView
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    //设置分页
    scrollView.pagingEnabled = YES;
    //隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    
    // 给SCrollView添加图片控件
    NSArray *arrImageNames = @[@"Guide_1.jpg", @"Guide_2.jpg", @"Guide_3.jpg", @"Guide_4.jpg",@"Guide_5.jpg"];
    //取出图片个数
    NSUInteger count = arrImageNames.count;
    UIView *view = [UIView new];
    [scrollView addSubview:view];
    //自动布局contentsize
   [view mas_makeConstraints:^(MASConstraintMaker *make) {
       make.leading.mas_equalTo(scrollView.mas_leading);
       make.top.mas_equalTo(scrollView.mas_top);
       make.bottom.mas_equalTo(scrollView.mas_bottom);
       make.trailing.mas_equalTo(scrollView.mas_trailing);
       
       make.width.mas_equalTo(scrollView.mas_width).multipliedBy(count);
       
       make.height.mas_equalTo(scrollView.mas_height);
   }];
    
    //上一个View
    UIView *viewBefore;
    
    //循环创建UIImageView
    for (NSUInteger index = 0; index < count; index ++) {
        //创建imageView对象
        UIImageView *imageView = [UIImageView new];
        //每个imageView的图片
        imageView.image = [UIImage imageNamed:arrImageNames[index]];
        //添加到俯视图上
        [view addSubview:imageView];
        
        //用第三方库Masonry自动布局每一个imageView
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            //imageView的上、下等同于contentsize（滚动内容视图）
            make.top.bottom.equalTo(view);
            //如果是第一个imageView
            if (index == 0) {
                //imageView的左边等同于contentsize（滚动内容视图）
                make.leading.equalTo(view);
            }
            else {
                //imageView的左边等同于上一个视图的右边
                make.leading.equalTo(viewBefore.mas_trailing);
                //imageView的宽等同于上一个视图的宽
                make.width.equalTo(viewBefore);
            }
            //如果是最后一张图片
            if (index == count - 1) {
                //imageView的右边等同于contentsize（滚动内容视图）的右边
                make.trailing.equalTo(view);
                
            }
        }];
        if (index == count - 1) {
            [self loadEnjoyButton:imageView];
        }
        //把新的视图赋值给到上个视图
        viewBefore = imageView;
    }
}

- (void)loadEnjoyButton:(UIImageView *)imageView {
    UIButton *btnEnjoy = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnEnjoy setTitle:@"立即体验" forState:UIControlStateNormal];
    [btnEnjoy setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //设置字体大小
    btnEnjoy.titleLabel.font = [UIFont italicSystemFontOfSize:20];
    
    [imageView addSubview:btnEnjoy];
    imageView.userInteractionEnabled = YES;
    [btnEnjoy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView).offset(500);
        make.trailing.equalTo(imageView).offset(-130);
        make.width.equalTo(@(100));
        make.height.equalTo(@(60));
    }];
    
    [btnEnjoy.layer setCornerRadius:5.0];
    [btnEnjoy.layer setBorderColor:[UIColor orangeColor].CGColor];
    [btnEnjoy.layer setBorderWidth:1.0];
    [btnEnjoy.layer setMasksToBounds:YES];
    
    [btnEnjoy addTarget:self action:@selector(tapEnjoyAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapEnjoyAction {
    // 保存版本号
    // NSUserDefaults:单例, 用法类似NSDictionary 就是能把信息存储到Bundle中的一个plist文件中
    NSString *strVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:strVersion forKey:@"oldVersionKey"];
    [[NSUserDefaults standardUserDefaults] synchronize]; // 强制现在就写入plist
    
    //NSLog(@"%@", NSHomeDirectory());
    
    // 跳转
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate loadMainController];
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
