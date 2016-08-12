//
//  HomeCollectViewCell.m
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HomeCollectViewCell.h"
#import "HomeTableViewCell.h"
#import "Home1TableViewCell.h"

@interface HomeCollectViewCell()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

//向网络请求多少页的索引
@property (nonatomic, assign) NSUInteger indexPage;

//向网络请求的参数
@property (nonatomic, copy) NSDictionary *parameter;

@end
@implementation HomeCollectViewCell

-(void)setArray:(NSArray *)array{
    _array =array;
    [self.tableView reloadData];
}


-(void)loadDefiltSetting{

    if (_tableView == nil) {
        UITableView *tableView = [UITableView new];// 默认plain样式
        tableView.frame = self.contentView.frame;
        tableView.dataSource = self;
        tableView.delegate = self;
        self.tableView = tableView;
        [self addSubview:tableView];
    }

    //分割线
    _tableView.separatorColor = [UIColor grayColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [UIView animateWithDuration:0.01 animations:^{
        [self.tableView setContentOffset:CGPointMake(0, 0)];
    }];
    [_tableView reloadData];
     
}

#pragma mark - 🎬 Action Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel *model = self.array[indexPath.row];
    
    if ([model.strType isEqualToString:@"doc"]) {
        HomeTableViewCell *cell = [HomeTableViewCell TableViewCellWithTableView:tableView];
        cell.homeModel = model;
        return cell;
    }else if([model.strType isEqualToString:@"slide"]){
        Home1TableViewCell *cell = [Home1TableViewCell TableViewCellWithTableView:tableView];
        cell.homeModel = model;
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
    HomeModel *model = self.array[indexPath.row];
    NSLog(@"%@",indexPath);
    if (self.blockWhichLine) {
        self.blockWhichLine(model.strUrl,model.strType);
    }
    
}

//当停止拖动,将要减速的时候,判断是否需要加载更多
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
        
        NSLog(@"我被调用了");
        
        //调用加载更多数据
        self.indexPage += 1;
        NSLog(@"我被调用了");
        NSDictionary *dict = @{@"page":@(self.indexPage)};
        self.parameter = dict;
        //向外传递参数字典
        if(self.blockParameter){
            self.blockParameter(self.parameter);
        }
    }
}



@end
