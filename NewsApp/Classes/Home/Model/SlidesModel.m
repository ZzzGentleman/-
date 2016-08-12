//
//  SlidesModel.m
//  NewsApp
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SlidesModel.h"

@implementation SlidesModel

+(instancetype)slidesModelWithDict:(NSDictionary *)dict{
    SlidesModel *model = [SlidesModel new];
    model.strImage = dict[@"image"];
    model.strTitle = dict[@"title"];
    model.strDesciption = dict[@"description"];
    return model;
}

//捕捉到字典中未定义的关键字
-(void) setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"不存在改字段%@",key);
}

@end
