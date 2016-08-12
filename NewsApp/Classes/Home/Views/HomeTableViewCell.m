//
//  HomeTableViewCell.m
//  NewsApp
//
//  Created by qingyun on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell ()
/** 缩略图 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@end
@implementation HomeTableViewCell

+(instancetype)TableViewCellWithTableView:(UITableView *)tableView {
    
    static NSString *strID = @"HomeTableViewCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:strID owner:nil options:nil] firstObject];
    }
    
    return cell;
    
}
-(void)setHomeModel:(HomeModel *)homeModel{
    _homeModel = homeModel;
    //图片
    NSURL * url = [NSURL URLWithString:homeModel.strThumbnail];
    [self.imageViewIcon sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveDownload];
    //标题
    self.labelTitle.text = homeModel.strTitle;
    //时间
    self.labelTime.text = homeModel.strUpdateTime;
}

@end
