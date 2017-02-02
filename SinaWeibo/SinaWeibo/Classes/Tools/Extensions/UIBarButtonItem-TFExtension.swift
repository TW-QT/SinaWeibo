//
//  UIBarButtonItem-TFExtension.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/9/29.
//  Copyright © 2017年 http://taofei.me All rights reserved.
//

import UIKit


extension UIBarButtonItem{

    
    ///通过图片名称来创建UIBarButtonItem （方法一）
//     convenience init(imageName :String) {
//        
//        self.init()
//        let btn = UIButton()
//        btn.setImage(UIImage(named : imageName), for: .normal)
//        btn.setImage(UIImage(named : imageName + "_highlighted"), for: .highlighted)
//        btn.sizeToFit()
//        self.customView = btn
//    }

    ///通过图片名称来创建UIBarButtonItem（方法二）
    convenience init(imageName :String) {
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        btn.setImage(UIImage(named : imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        self.init(customView : btn)
    }
}
