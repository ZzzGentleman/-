//
//  Home1TableViewCell.m
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "Home1TableViewCell.h"

@interface Home1TableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFirst;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewSecond;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThird;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@end

@implementation Home1TableViewCell

+(instancetype)TableViewCellWithTableView:(UITableView *)tableView {
    
    static NSString *strID = @"Home1TableViewCell";
    Home1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:strID owner:nil options:nil] firstObject];
    }
    
    return cell;
    
}

-(void)setHomeModel:(HomeModel *)homeModel{
    _homeModel = homeModel;
    //标题
    self.labelTitle.text = homeModel.strTitle;
    //时间
    self.labelTime.text = homeModel.strUpdateTime;
    //图片1
    NSURL *url = [NSURL URLWithString:homeModel.images[0]];
    [self.imageViewFirst sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveDownload];
     //图片2
    NSURL *url1 = [NSURL URLWithString:homeModel.images[1]];
    [self.ImageViewSecond sd_setImageWithURL:url1 placeholderImage:nil options:SDWebImageProgressiveDownload];
     //图片3
    NSURL *url2 = [NSURL URLWithString:homeModel.images[2]];
    [self.imageViewThird sd_setImageWithURL:url2 placeholderImage:nil options:SDWebImageProgressiveDownload];
}

@end
