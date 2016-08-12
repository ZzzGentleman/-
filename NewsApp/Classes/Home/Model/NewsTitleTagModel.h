//
//  NewsTitleTagModel.h
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsTitleTagModel : NSObject

/** 标题 */
@property (nonatomic, strong) NSString *strNewsTitle;
/** 网络请求的URL */
@property (nonatomic, strong) NSString *strNewsPlistName;

+(instancetype)modelWithDictionary:(NSDictionary *)dicData;

@end
