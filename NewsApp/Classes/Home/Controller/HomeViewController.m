//
//  HomeViewController.m
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HomeViewController.h"
#import "ButtonView.h"
#import "HomeCollectViewCell.h"
#import "NewsTitleTagModel.h"
#import "WEBViewController.h"
#import "SlidesViewController.h"

#import "HomeModel.h"

@interface HomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
/** 首页新闻的模型数组 */
@property (nonatomic, copy) NSArray *arrNewsTitleTagModel;
/** 网络获取的模型数组 */
@property (nonatomic, copy) NSMutableArray *arrHomeModel;
/** 按钮的视图 */
@property (nonatomic, weak) ButtonView *btnView;
/** 创建网络请求的管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 网络请求的URL */
@property (nonatomic, copy) NSString *strURL;
/** 标题按钮传过来按钮下标 */
@property (nonatomic, assign) NSUInteger indexBtn;
/** 网络请求的参数字典 */
@property (nonatomic, copy) NSDictionary *dictParameter;

@property (nonatomic, weak) UICollectionView *collectionView;


@end

@implementation HomeViewController

//视图将要加载的时候调用
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidDisappear:(BOOL)animated
{
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
}


static NSString * const reuseIdentifier = @"Cell";

//懒加载新闻模型数组
-(NSArray *)arrNewsTitleTagModel{
    if (_arrNewsTitleTagModel == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"newsTitleTag" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            NewsTitleTagModel *model = [NewsTitleTagModel modelWithDictionary:dic];
            [models addObject:model];
        }
        _arrNewsTitleTagModel = [models copy];
    }
    return _arrNewsTitleTagModel;
}

//懒加载网络请求的管理者
-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [_manager.reachabilityManager startMonitoring];
    }
    return _manager;
}


//重写初始化方法
//-(instancetype)init{
//    
//    
//    
//    
//    
//    return [super initWithCollectionViewLayout:flowLayout];
//}

- (void)loadDefaultSetting {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    //最小间距
    flowLayout.minimumInteritemSpacing = 0;
    //最小列距
    flowLayout.minimumLineSpacing = 0;
    
    //cell 大小
    flowLayout.itemSize = CGSizeMake(QLScreenWidth, QLScreenHeight - 145);
    
    //边距
    flowLayout.sectionInset = UIEdgeInsetsMake(30, 0, 0, 0);
    //滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.equalTo(self.view);
    }];
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDefaultSetting];
    
    
//    //网络请求
//    [self NetworkRequest];
    
 
    // Register cell classes
    //XIB注册方式
//    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCollectViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    //类的注册方法
    [self.collectionView registerClass:[HomeCollectViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //启动分页
    self.collectionView.pagingEnabled = YES;
    //隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置数据源
    self.collectionView.dataSource = self;
    // 设置代理
    self.collectionView.delegate = self;
    
    
    //添加按钮View
    ButtonView *btnVc = [ButtonView new];
    //隐藏水平滚动条
    btnVc.showsHorizontalScrollIndicator = NO;
    //把按钮的View设置成全局的
    self.btnView = btnVc;
    
    [self.view addSubview:btnVc];
    
    btnVc.arrBtnView = self.arrNewsTitleTagModel;
    [btnVc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(@0);
        make.height.equalTo(@30);
    }];
    btnVc.backgroundColor = [UIColor whiteColor];
    //弱引用self
    __weak typeof(self) selfWeak = self;
    
    [btnVc setBlkDidChooseButtonAtIndex:^(NSUInteger index) {
        [selfWeak.collectionView setContentOffset:CGPointMake(index * [UIScreen mainScreen].bounds.size.width, 0) animated:YES];
    }];
    
    [btnVc setBlkTheURL:^(NSString *url) {
        selfWeak.strURL = url;
        [selfWeak NetworkRequest];
    }];
    // Do any additional setup after loading the view.
}

//网络请求
-(void)NetworkRequest{
    
    if (_strURL == nil) {
        NewsTitleTagModel *model = self.arrNewsTitleTagModel[0];
        _strURL = model.strNewsPlistName;
    }
    
    [self.manager GET:self.strURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        
        if (httpResponse.statusCode == 200) {
            //解析数据
            //判断是不是数组
            if ([responseObject isKindOfClass:[NSArray class]]) {
                //取出需要的数组
                //方式一
//                NSArray *arrHomeTemp = (NSArray *)responseObject[0][@"item"];
                //方式二
                NSArray *arrayJSON = responseObject;
                NSDictionary *dict0 = arrayJSON[0];
                NSArray *arrHomeTemp = dict0[@"item"];

                //定义可变数组用来保存数据
                NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:arrHomeTemp.count];
                //定义取出来的数组
                for (NSDictionary *dic in arrHomeTemp) {
                    HomeModel *model = [HomeModel homeModelWithDictionary:dic];
                    if ([model.strType isEqualToString:@"doc"]||[model.strType isEqualToString:@"slide"]) {
                        [mutableArr addObject:model];
                    }
                    
                }
                self.arrHomeModel = mutableArr;
                //数据加载完成之后用子线程重新加载UI
                
                    [self.collectionView reloadData];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrNewsTitleTagModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCollectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //用Block传值的方式把点击的cell的详情传到这控制器
    __weak typeof(self) weakSelf = self;
    [cell setBlockWhichLine:^(NSString *detailsUrl,NSString *detailsType) {
        if ([detailsType isEqualToString:@"doc"]) {
            WEBViewController *webViewController = [WEBViewController new];
            webViewController.Url = detailsUrl;
            [weakSelf.navigationController pushViewController:webViewController animated:YES];
        }else if([detailsType isEqualToString:@"slide"]){
            SlidesViewController *slidesViewController = [SlidesViewController new];
            slidesViewController.Url = detailsUrl;
            [weakSelf.navigationController pushViewController:slidesViewController animated:YES];
        }
    }];
    
    //回调网络请求参数
    [cell setBlockParameter:^(NSDictionary *dict) {
        weakSelf.dictParameter = dict;
        [weakSelf NetworkRequest];
    }];
    //网络获取的模型赋值给cell的数组
    cell.array = self.arrHomeModel;
    
    // Configure the cell
    [cell loadDefiltSetting];
    
    return cell;
}
//滚动结束时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat x = self.collectionView.contentOffset.x;
    NSUInteger index = x / [[UIScreen mainScreen] bounds].size.width;
    [self.btnView chooseButtonWithTitle:index];
    //滚动结束调用加载
    [self NetworkRequest];
}



@end
