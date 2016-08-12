//
//  HomeCollectViewCell.h
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;

@interface HomeCollectViewCell : UICollectionViewCell

-(void)loadDefiltSetting;
//接收控制器的传HomeModel的数组
@property (nonatomic, copy) NSArray *array;

@property (nonatomic, strong) void(^blockWhichLine)(NSString * detailsUrl,NSString *detailsType);
//网络请求传递的参数
@property (nonatomic, strong) void(^blockParameter)(NSDictionary *dict);
@end
