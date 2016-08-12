//
//  ButtonView.h
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//  LoveMage
//

#import <UIKit/UIKit.h>
#import "NewsTitleTagModel.h"

@interface ButtonView : UIScrollView

/** 所有按钮的标题 */
@property (nonatomic, copy) NSArray *arrBtnView;

//设置传值方法
- (void) chooseButtonWithTitle:(NSUInteger )index;

/** 按钮的点击事件传递TAG值 */
@property (nonatomic, copy) void (^blkDidChooseButtonAtIndex)(NSUInteger index);
/** 按钮的点击事件传递URL */
@property (nonatomic, copy) void (^blkTheURL)(NSString * url);

@end
