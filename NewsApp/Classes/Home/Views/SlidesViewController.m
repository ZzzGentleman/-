//
//  SlidesViewController.m
//  NewsApp
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SlidesViewController.h"
#import "AFNetworking.h"
#import "SlidesModel.h"
#import "UIImageView+WebCache.h"


@interface SlidesViewController ()<UIScrollViewDelegate>
//创建网路请求管理者
@property (nonatomic, strong) AFHTTPSessionManager *manager;
//滚动视图
@property (nonatomic, weak) UIScrollView *scrollView;
/** 网络获取的模型数组 */
@property (nonatomic, copy) NSArray <SlidesModel *> *arrSlidesModel;

@end

@implementation SlidesViewController

//懒加载网络请求的管理者
-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [_manager.reachabilityManager startMonitoring];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.Url);
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    [self loadDefaultSetting];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadDefaultSetting{
    //创建一个UIScrollView的对象
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    scrollView.delegate = self;
    self.scrollView = scrollView;
    
    //进行网络请求
    [self.manager GET:self.Url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        
        if (httpResponse.statusCode == 200){
            //解析数据
            //判断是不是字典
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //取出需要的数组
                NSDictionary *arrJSON = responseObject;
                NSDictionary *body = arrJSON[@"body"];
                NSArray *slides = body[@"slides"];
                
                //定义可变数组用来保存数据
                NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:slides.count];
                //定义取出来的数组
                for (NSDictionary *dic in slides) {
                    SlidesModel *model = [SlidesModel slidesModelWithDict:dic];
                    [mutableArr addObject:model];
                }
                self.arrSlidesModel = mutableArr;
                //数据加载完成之后用子线程重新加载UI
                [self reloadData];
                
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)reloadData {
    //取出图片个数
    NSUInteger count = self.arrSlidesModel.count;
    //设置内容的尺寸
    self.scrollView.contentSize = CGSizeMake(count * [[UIScreen mainScreen] bounds].size.width, 0);
    //设置分页
    self.scrollView.pagingEnabled = YES;
    //隐藏水平的指示器
    self.scrollView.showsHorizontalScrollIndicator = YES;
    for (NSUInteger index = 0; index < count; index ++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imageView];
        imageView.frame = CGRectMake(index * self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height / 2);
        NSString *str = self.arrSlidesModel[index].strImage;
        [imageView sd_setImageWithURL:[NSURL URLWithString:str]];
        
        UILabel *label = [[UILabel alloc] init];
        [self.scrollView addSubview:label];
        label.frame = CGRectMake(index * self.scrollView.bounds.size.width, self.scrollView.bounds.size.height/ 2  + 50, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height / 2 - 50);
//        label.backgroundColor = [UIColor orangeColor];
        label.numberOfLines = 0;
        label.text = self.arrSlidesModel[index].strDesciption;
        
        UILabel *label1 = [[UILabel alloc] init];
        [self.scrollView addSubview:label1];
        label1.frame = CGRectMake(index * self.scrollView.bounds.size.width, self.scrollView.bounds.size.height/ 2, self.scrollView.bounds.size.width, 50);
        NSLog(@"%lu/%lu",(unsigned long)index + 1,(unsigned long)self.arrSlidesModel.count);
        NSString *str1 = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)index + 1,(unsigned long)self.arrSlidesModel.count];
        label1.text =str1;
    }
}

-(void)dealloc{
    NSLog(@"SlidesViewController死了");
}


@end
