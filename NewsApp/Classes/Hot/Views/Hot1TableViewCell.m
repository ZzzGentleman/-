//
//  Hot1TableViewCell.m
//  NewsApp
//
//  Created by qingyun on 16/8/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "Hot1TableViewCell.h"
@interface  Hot1TableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFirest;
@property (weak, nonatomic) IBOutlet UIImageView *imaheViewSecond;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThird;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;


@end

@implementation Hot1TableViewCell

+(instancetype)TableViewCellWithTableView:(UITableView *)tableView {
    
    static NSString *strID = @"Hot1TableViewCell";
    Hot1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:strID owner:nil options:nil] firstObject];
    }
    
    return cell;
    
}

-(void)setHotModel:(HotModel *)hotModel{
    _hotModel = hotModel;
    //标题
    self.labelTitle.text = hotModel.strTitle;
    //时间
    self.labelTime.text = hotModel.strUpdateTime;
    //图片1
    NSURL *url = [NSURL URLWithString:hotModel.images[0]];
    [self.imageViewFirest sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveDownload];
    //图片2
    NSURL *url1 = [NSURL URLWithString:hotModel.images[1]];
    [self.imaheViewSecond sd_setImageWithURL:url1 placeholderImage:nil options:SDWebImageProgressiveDownload];
    //图片3
    NSURL *url2 = [NSURL URLWithString:hotModel.images[2]];
    [self.imageViewThird sd_setImageWithURL:url2 placeholderImage:nil options:SDWebImageProgressiveDownload];
}

@end
