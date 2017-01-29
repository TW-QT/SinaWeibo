//
//  TFVisitorView.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2017/1/27.
//  Copyright © 2017年 taofei.me. All rights reserved.
//

import UIKit

class TFVisitorView: UIView {

    //MARK:- 控件的属性
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipsLabel: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    //MARK:- 自定义函数



    
    ///设置访客视图
    func setupVisitorViewInfo(iconName : String ,tip :String){
    
        iconView.image = UIImage(named: iconName)
        tipsLabel.text = tip
        rotationView.isHidden = true
    }
    
    ///添加rotationView的动画
    func addRotationViewAnimation(){
        //1.创建动画:CABasicAnimation或者CAKeyframeAnimation来实现
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        //2.设置动画的属性
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = M_PI * 2
        rotationAnimation.repeatCount = MAXFLOAT
        rotationAnimation.duration = 5
        rotationAnimation.isRemovedOnCompletion = false
        //3.将动画添加到layer中
        rotationView.layer.add(rotationAnimation, forKey: nil)    
    }
    
    //MARK:- 提供快速通过Xib创建的类方法
    class func TFVisitorView() -> TFVisitorView {
        return Bundle.main.loadNibNamed("TFVisitorView", owner: nil, options: nil)?.first as! TFVisitorView
    }

}
