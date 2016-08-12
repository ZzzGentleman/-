//
//  NewsAppInfoDb.m
//  NewsApp
//
//  Created by qingyun on 16/8/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsAppInfoDb.h"

@implementation NewsAppInfoDb
//单例的初始化对象
+(id)shareInstance{
    static NewsAppInfoDb *shanredInstance=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shanredInstance=[[self alloc] init];
    });
    return shanredInstance;
}
-(id)init{
    if (self = [super init]) {
        [self initDb];
    }
    return self;
}
//初始化数据库
-(void) initDb{
    self.queue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    [self.queue inDatabase:^(FMDatabase *db) {
        //创建表
        NSString *sql = @"CREATE TABLE NewsApp (title text,thumbnail text,updateTime text)";
        if ([db executeUpdate:sql]) {
            NSLog(@"初始化数据库成功");
        }else{
            NSLog(@"初始化数据库失败");
        }
    }];
}
//插入热门记录之前,要把之前插入的数据删掉
-(void)InsertStatues:(NSMutableArray *)arr{
    [self delete];
    for (NSUInteger index = 0; index < arr.count; index ++) {
        HotModel *status = [arr objectAtIndex:index];
        
        [self Insert:status];
    }
}
//给表添加数据
-(void) Insert:(HotModel *) status{
    //序列化的方式archivedDataWithRootObject 需要自动调用该对象中nscoding协议中的encoder 进行归档
    NSDictionary *dict = @{@"title":status.strTitle,
                          @"thumbnail":status.strThumbnail,
                          @"updateTime":status.strUpdateTime};
    [self.queue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:Insert_Hot_Sql withParameterDictionary:dict]) {
            NSLog(@"数据库插入成功");
        }else{
            NSLog(@"数据库插入失败 %@",[db lastErrorMessage]);
        }
    }];
}
-(void) delete{
    //    //FMDatabaseQueue 异步的方式
    //    [self.queue inDatabase:^(FMDatabase *db){
    //        if ([db executeQuery:Delete_Home_Sql]) {
    //            NSLog(@"删除成功");
    //        }
    //    }];
    //同步的方式
    FMDatabase *db=[FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        [db executeUpdate:Insert_Hot_Sql];
    }
    [db close];
}
//查询热门主页数据
-(NSMutableArray *)Query{
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:Insert_Hot_Sql];
        while ([rs next]) {
            //方式一：通过手动解析指定的字段
            HotModel *qHotModel = [[HotModel alloc] init];
            qHotModel.strTitle = [rs stringForColumn:@"title"];
            qHotModel.strThumbnail = [rs stringForColumn:@"thumbnail"];
            qHotModel.strUpdateTime = [rs stringForColumn:@"updateTime"];
            [mArr addObject:qHotModel];
        }
    }
    //关闭数据库
    [db close];
    return mArr;
}

@end
