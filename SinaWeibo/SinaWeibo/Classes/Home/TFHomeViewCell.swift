//
//  TFHomeViewCell.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/10/3.
//  Copyright © 2016年 http://taofei.me All rights reserved.
//

import UIKit

let edgeMargin : CGFloat = 15

class TFHomeViewCell: UITableViewCell {

    //MARK:- 约束的属性
    @IBOutlet weak var textLabelConstant: NSLayoutConstraint!
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置微博正文的宽度约束
        textLabelConstant.constant = UIScreen.main.bounds.width - edgeMargin * 2
        
    }

}
