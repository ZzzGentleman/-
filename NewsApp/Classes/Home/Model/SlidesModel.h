//
//  SlidesModel.h
//  NewsApp
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SlidesModel : NSObject

@property (nonatomic, copy) NSArray *arrSlides;


/** 图片的名称 */
@property (nonatomic, copy) NSString *strImage;
/** 标题 */
@property (nonatomic, copy) NSString *strTitle;
/** 描述 */
@property (nonatomic, copy) NSString *strDesciption;

+(instancetype) slidesModelWithDict:(NSDictionary *)dict;

@end
