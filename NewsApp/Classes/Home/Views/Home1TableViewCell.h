//
//  Home1TableViewCell.h
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface Home1TableViewCell : UITableViewCell

/** 当前cell显示的数据 */
@property (nonatomic, strong) HomeModel *homeModel;

//重用的cell初始化方式
+ (instancetype)TableViewCellWithTableView:(UITableView *)tableView;

@end
