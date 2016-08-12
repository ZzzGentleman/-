//
//  HomeModel.m
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HomeModel.h"
#import "NSDate+NSDate.h"

@implementation HomeModel

+(instancetype)homeModelWithDictionary:(NSDictionary *)dicData{
    HomeModel *model = [HomeModel new];
    //标题
    model.strTitle = dicData[@"title"];
    //图片
    model.strThumbnail = dicData[@"thumbnail"];
    //时间
    NSString *strTime = dicData[@"updateTime"];
    if (strTime) {
        NSDate *date = [NSDate dateWithString:strTime];
        model.strUpdateTime = [model dateStringFormDate:date];
    }
    //样式
    model.strType = dicData[@"type"];
    //三张图片的字典
    model.style = dicData[@"style"];
    //三张图片的数组
    model.images = model.style[@"images"];
    //详情的字典
    model.strlink = dicData[@"link"];
    //详情的URL
    model.strUrl = model.strlink[@"url"];
    
    
    return model;
}

-(id)init{
    if (self = [super init]) {
        //初始化字典
        self.style = [NSDictionary dictionary];
        //初始化数组
        self.images = [NSArray array];
    }
    return self;
}


- (NSString *)dateStringFormDate:(NSDate *)date {
    
    NSTimeInterval interval = -[date timeIntervalSinceNow];
    if(interval < 60){
        return @"刚刚";
    } else if (interval < 60 * 10) {// 分
        return [NSString stringWithFormat:@"%d分钟前",(int)(interval / 60)];
    } else if (interval < 60 * 60 * 24) {// 一天内
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        return [formatter stringFromDate:date];
    } else if (interval < 60 * 60 * 24 * 30 && interval >= 60 * 60 * 24) {// 天
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
        return [formatter stringFromDate:date];
    }
    return nil;
    
}
@end
