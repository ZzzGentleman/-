//
//  HotModel.h
//  NewsApp
//
//  Created by qingyun on 16/8/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotModel : NSObject

/** 网络获取的标题 */
@property (nonatomic, copy) NSString *strTitle;

/** 网络获取的图片 */
@property (nonatomic, copy) NSString *strThumbnail;

/** 网络获取的发布时间 */
@property (nonatomic, copy) NSString *strUpdateTime;

/** 样式 */
@property (nonatomic, copy) NSString *strType;

/** 三张图片的字典 */
@property (nonatomic, copy) NSDictionary *style;
/** 三张图片的数组 */
@property (nonatomic, copy) NSArray *images;
/** 详情的字典 */
@property (nonatomic, copy) NSDictionary *strlink;
/** 详情的URL */
@property (nonatomic, copy) NSString *strUrl;


/** 便利的初始化方式 */
+(instancetype) hotModelWithDictionary:(NSDictionary *)dicData;
@end
