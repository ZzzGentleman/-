//
//  HotTableViewCell.m
//  NewsApp
//
//  Created by qingyun on 16/8/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HotTableViewCell.h"

@interface HotTableViewCell ()
/** 缩略图 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *labTime;


@end

@implementation HotTableViewCell

+(instancetype)TableViewCellWithTableView:(UITableView *)tableView {
    
    static NSString *strID = @"HotTableViewCell";
    HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:strID owner:nil options:nil] firstObject];
    }
    
    return cell;
    
}

-(void)setHotModel:(HotModel *)hotModel{
    _hotModel = hotModel;
    
    //图片
    NSURL *url = [NSURL URLWithString:hotModel.strThumbnail];
    [self.imageViewIcon sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveDownload];
    //标题
    self.labelTitle.text = hotModel.strTitle;
    //时间
    self.labTime.text = hotModel.strUpdateTime;
}

@end
