//
//  NewsTitleTagModel.m
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsTitleTagModel.h"

@implementation NewsTitleTagModel

+(instancetype)modelWithDictionary:(NSDictionary *)dicData{
    NewsTitleTagModel *model = [NewsTitleTagModel new];
    
    model.strNewsTitle = dicData[@"newsTitle"];
    model.strNewsPlistName = dicData[@"newsPlistName"];
    return model;
}

@end
