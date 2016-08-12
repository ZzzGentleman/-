//
//  AbstractDb.h
//  NewsApp
//
//  Created by qingyun on 16/8/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
//数据库的文件名
#define DB_FileName @"NewsApp.sqlite"
//删除之前保存的数据
#define Insert_Hot_Sql @"delete FROM NewsApp"
@interface AbstractDb : NSObject

/** 数据库文件路径 */
@property(nonatomic,strong) NSString *dbPath;
/** 数据库操作队列 */
@property(nonatomic,strong) FMDatabaseQueue *queue;
-(id) init;
@end
