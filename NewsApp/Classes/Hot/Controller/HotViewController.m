//
//  HotViewController.m
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//  LoveMage
//

#import "HotViewController.h"
#import "HotTableViewCell.h"
#import "Hot1TableViewCell.h"
#import "HotWebViewController.h"
#import "SlidesViewController.h"
#import "HotModel.h"
#import "NewsAppInfoDb.h"

#define STRURL @"http://api.iclient.ifeng.com/ClientNews?id=SYLB10,SYDT10"

@interface HotViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 创建网络请求的管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 网络获取热门的模型数组 */
@property (nonatomic, copy) NSMutableArray *arrHotModel;

@property (nonatomic, weak) UITableView *tableView;

//加载更多按钮
@property (nonatomic, weak) UIButton *footerBtn;

//向网络请求多少页的索引
@property (nonatomic, assign) NSUInteger indexPage;

//向网络请求的参数
@property (nonatomic, copy) NSDictionary *parameter;

@end

@implementation HotViewController

//懒加载数组让其有地址  可以使用
-(NSMutableArray *)arrHotModel
{
    if (_arrHotModel == nil) {
        _arrHotModel = [NSMutableArray array];
    }
    return _arrHotModel;
}

//视图将要加载的时候调用
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    ;
        [self LoadTheDefault];

    // Do any additional setup after loading the view.
}
-(void) LoadTheDefault{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // DataSource 就是给显示数据的view提供数据的对象
    tableView.dataSource = self;
    // 设置代理
    tableView.delegate = self;
    self.tableView = tableView;
    //把TableView添加在控制器的View上
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.equalTo(@0);
    }];
    
        [self NetworkRequest];
}

//当停止拖动,将要减速的时候,判断是否需要加载更多
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
        //调用加载更多数据
        self.indexPage += 1;
        NSLog(@"我被调用了");
        NSDictionary *dict = @{@"page":@(self.indexPage)};
        self.parameter = dict;
        [self NetworkRequest];
    }
}

//网络请求
-(void)NetworkRequest{
    
    [self.manager GET:STRURL parameters:self.parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        
        if (httpResponse.statusCode == 200) {
            //解析数据
            //判断是不是字典
            if ([responseObject isKindOfClass:[NSArray class]]) {
                //方式二
                NSArray *arrayJSON = responseObject;
                NSDictionary *dict0 = arrayJSON[0];
                NSArray *arrHomeTemp = dict0[@"item"];
                //定义可变数组用来保存数据
                NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:arrHomeTemp.count];
                //定义取出来的数组
                //将数组里面的数据遍历到字典中
                for (NSDictionary *dic in arrHomeTemp) {
                    //用遍历的字典初始化模型
                    HotModel *model = [HotModel hotModelWithDictionary:dic];
                    if ([model.strType isEqualToString:@"doc"]||[model.strType isEqualToString:@"slide"]) {
                        //把模型在添加到可遍数组中
                        [mutableArr addObject:model];
                    }
                    
                }
//                self.arrHotModel = mutableArr;
                [self.arrHotModel addObjectsFromArray:mutableArr];
            
                //数据加载完成之后用子线程重新加载UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败%@",error);
    }];
    
}

/** tableView中有几个Section */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
/** 某个section中有几个cell */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrHotModel.count;
}
/** 每个row显示的内容 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotModel *model = self.arrHotModel[indexPath.row];
    if ([model.strType isEqualToString:@"doc"]) {
        HotTableViewCell *cell = [HotTableViewCell TableViewCellWithTableView:tableView];
        cell.hotModel = model;
        return cell;
    }else if([model.strType isEqualToString:@"slide"]){
        Hot1TableViewCell *cell = [Hot1TableViewCell TableViewCellWithTableView:tableView];
        cell.hotModel = model;
        return cell;
    }else{
        return nil;
    }
   
}
/** 设置行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

/**选中了某个cell(cell是显示的内容,继承自UIView, row:行号) */
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    HotModel *model = self.arrHotModel[indexPath.row];
    if ([model.strType isEqualToString:@"doc"]) {
        HotWebViewController *vc = [[HotWebViewController alloc] init];
        vc.Url = model.strUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([model.strType isEqualToString:@"slide"]){
        SlidesViewController *vc = [[SlidesViewController alloc] init];
        vc.Url = model.strUrl;
        [self.navigationController pushViewController:vc animated:YES];
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
