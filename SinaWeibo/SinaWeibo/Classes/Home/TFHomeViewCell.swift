//
//  TFHomeViewCell.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/10/3.
//  Copyright © 2016年 http://taofei.me All rights reserved.
//

import UIKit
import SDWebImage

let edgeMargin : CGFloat = 15

class TFHomeViewCell: UITableViewCell {
    
    //MARK:- 控件属性
    @IBOutlet weak var avartaImageView: UIImageView!
    @IBOutlet weak var vertifierImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var mumbershipImageView: UIImageView!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    //MARK:- 自定义属性
    var viewModel : TFStatusViewModel?{
        didSet{
            //1.nil值校验
            guard let viewModel = viewModel  else {
                return
            }
            //2.设置头像
            avartaImageView.sd_setImage(with: viewModel.profileURL, placeholderImage: UIImage(named : "avatar_default_small"))
            //3.设置认证图标
            vertifierImageView.image = viewModel.verifiedImage
            //4.设置昵称
            nickNameLabel.text = viewModel.status?.user?.screen_name
            //5.设置会员图标
            mumbershipImageView.image = viewModel.vipImage
            //6.设置时间
            createTimeLabel.text = viewModel.created_at_text
            //7.设置来源
            sourceLabel.text = viewModel.source_text
            //8.设置内容
            contentLabel.text = viewModel.status?.text
            //9.设置昵称的文字颜色
            nickNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
        }
    }

    //MARK:- 约束的属性
    @IBOutlet weak var textLabelConstant: NSLayoutConstraint!
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置微博正文的宽度约束
        textLabelConstant.constant = UIScreen.main.bounds.width - edgeMargin * 2
    }
}
