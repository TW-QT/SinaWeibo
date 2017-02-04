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
let imageItemMargin : CGFloat = 10

class TFHomeViewCell: UITableViewCell {
    
    //MARK:- 控件属性
    @IBOutlet weak var avartaImageView: UIImageView!
    @IBOutlet weak var vertifierImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var mumbershipImageView: UIImageView!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var picView: TFPicCollectionView!
    
    //MARK:- 控件约束
    @IBOutlet weak var picViewWconstant: NSLayoutConstraint!
    @IBOutlet weak var picViewHconstant: NSLayoutConstraint!
    
    
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
            //10.计算picView的宽度和高度约束
            let picViewSize = calculatePicViewSize(count: viewModel.picURLs.count)
            picViewWconstant.constant = picViewSize.width
            picViewHconstant.constant = picViewSize.height
            //11.将配图地址传过去
            picView.picURLs = viewModel.picURLs
        }
    }

    //MARK:- 约束的属性
    @IBOutlet weak var textLabelConstant: NSLayoutConstraint!
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置微博正文的宽度约束
        textLabelConstant.constant = UIScreen.main.bounds.width - edgeMargin * 2
        
        //1.取出picView对应的layout并将其转为流水布局
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * imageItemMargin) / 3
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
        
    }
}

//MARK:- 计算方法
extension TFHomeViewCell{

    ///计算picView的宽度和高度
    func calculatePicViewSize(count : Int) -> CGSize{
    
        //1.没有配图
        if count == 0 {
            return CGSize.zero
        }
        //2.计算出imageViewWH
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * imageItemMargin) / 3
        //3.四张配图的情况
        if count == 4 {
            let picViewW = imageViewWH * 2 + imageItemMargin
            return CGSize(width: picViewW, height: picViewW)
        }
        //4.其他张配图
        //4.1先计算行数
        let rows = CGFloat((count - 1) / 3 + 1)
        //4.2计算picView的高度
        let picViewH = rows * imageViewWH + (rows - 1) * imageItemMargin
        let picViewW = UIScreen.main.bounds.width - 2 * edgeMargin
        return CGSize(width: picViewW, height: picViewH)
    
    }

}


