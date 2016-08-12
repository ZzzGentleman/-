//
//  SlidesViewController.h
//  NewsApp
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlidesModel.h"

@interface SlidesViewController : UIViewController
//加载的URL
@property (nonatomic, copy) NSString *Url;

@property (nonatomic, strong) SlidesModel *model;

@end
