//
//  NewsAppInfoDb.h
//  NewsApp
//
//  Created by qingyun on 16/8/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "AbstractDb.h"
#import "HotModel.h"

@interface NewsAppInfoDb : AbstractDb
//单利的初始化对象
+(id) shareInstance;
/** 插入新闻热门中每条记录(热门)*/
-(void) InsertStatues:(NSMutableArray *) arr;
/** 查询热门数据 */
-(NSMutableArray *) Query;

@end
