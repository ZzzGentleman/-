//
//  ButtonView.m
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//  LoveMage
//

#import "ButtonView.h"

@implementation ButtonView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadUI];
    }
    return self;
}

-(void)loadUI{
    self.backgroundColor = [UIColor orangeColor];
}

-(void)setArrBtnView:(NSArray *)arrBtnView{
    _arrBtnView = [arrBtnView copy];
    
    //设置按钮的宽
    CGFloat itemWith = 80;
    //取出按钮的个数  跟传过来的标题个数一致
    NSUInteger count = arrBtnView.count;
    //设置滚动视图的可滚动范围
    [self setContentSize:CGSizeMake(count * itemWith, 1)];
    
    //利用循环来创建所有的按钮
    for (NSUInteger index = 0; index < arrBtnView.count; index ++) {
        NewsTitleTagModel *newsModel = arrBtnView[index];
        
        //初始化按钮必须设置类型
        UIButton *btnItem = [UIButton buttonWithType:UIButtonTypeCustom];
        //根据数组下标给每按钮设置标题
        [btnItem setTitle:newsModel.strNewsTitle forState:UIControlStateNormal];
        //给所有按钮的正常状态下标题的颜色
        [btnItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //给所有按钮选中的状态设置颜色
        [btnItem setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled
         ];
        //给所有按钮添加点击事件
        [btnItem addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchDown];
        //给每个按钮设置位置
        [btnItem setFrame:CGRectMake(index * itemWith, 0, itemWith, 40)];
        //        给每个按钮设置tag值
        btnItem.tag = index;
        //把每个按钮添加到滚动视图上
        [self addSubview:btnItem];
    }

}

- (void)chooseAction:(UIButton *)button{
    //把所有的UIbutton置为未选中
    //用for  in   找出所有的button
    for (UIButton *btn in self.subviews) {
        //判断是不是button类
        if ([btn isKindOfClass:[UIButton class]]) {
            //按钮是否可用
            btn.enabled = YES;
        }
    }
    
    // 选中用户选中的按钮, 如果contentSize的大小有一个为0, 这个方法就不起作用
    button.enabled = NO;
    //让指定的区域可见
//    [self scrollRectToVisible:button.frame animated:YES];
    
    //回调Block  把按钮的tag值传出去
    if (self.blkDidChooseButtonAtIndex) {
        self.blkDidChooseButtonAtIndex(button.tag);
    }
    //回调Blck 把按钮对应的URL值传出去
    if (self.blkTheURL) {
        NewsTitleTagModel *model = self.arrBtnView[button.tag];
        self.blkTheURL(model.strNewsPlistName);
    }
}
//将移动到窗口
- (void)willMoveToWindow:(UIWindow *)newWindow {
    //取出标题的个数
    
    NSUInteger count = self.arrBtnView.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *btnItem = self.subviews[index];
        if ([btnItem isKindOfClass:[UIButton class]] && btnItem.tag == 0) {
            [self chooseAction:btnItem];
            break;
        }
    }
}

//实现传值方法
- (void)chooseButtonWithTitle:(NSUInteger)index
{
    NSArray *arrSubviews = self.subviews;
    for (UIButton *button in arrSubviews) {
        if ([button isKindOfClass:[UIButton class]] && (button.tag == index)) {
            [self chooseAction:button];
            return;
        }
    }
}






@end
