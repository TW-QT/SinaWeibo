//
//  UIButton-TFExtension.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/9/26.
//  Copyright © 2017年 http://taofei.me All rights reserved.
//

import UIKit

extension UIButton{

    //Swift中类方法是以Class开头的方法，类似于OC中的+开头的类方法
    class func tf_creatBtn(imageName : String , bgImageName : String) -> UIButton {
        //1.创建按钮
        let btn = UIButton()
        //2.设置按钮的属性
        btn.setImage(UIImage(named : imageName), for: .normal)
        btn.setImage(UIImage(named : imageName + "_highlighted"), for: .highlighted)
        btn.setBackgroundImage(UIImage(named : bgImageName), for: .normal)
        btn.setBackgroundImage(UIImage(named : bgImageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        //返回按钮
        return btn
    }
    
    
    
    //构造函数实现对象的初始化
    /// 根据按钮图片和按钮的背景图片实现按钮对象的创建
    convenience init(imageName : String , bgImageName : String) {
        self.init()
        setImage(UIImage(named : imageName), for: .normal)
        setImage(UIImage(named : imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named : bgImageName), for: .normal)
        setBackgroundImage(UIImage(named : bgImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }


}
