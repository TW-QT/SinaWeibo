//
//  TFPopPresentationController.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2017/1/29.
//  Copyright © 2017年 taofei.me. All rights reserved.
//

import UIKit

class TFPopPresentationController: UIPresentationController {
    
    //MARK:- 懒加载属性
    lazy var coverView : UIView = UIView()
    lazy var presentedFrame : CGRect = CGRect.zero
    
   
    //MARK:- 系统回调函数

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //1.设置弹出View的frame
        presentedView?.frame = presentedFrame//CGRect(x: 75, y: 55, width: 180 , height: 250)
        //2.添加HUD
        setupCoverView()
    }
}


//MARK:- 设置界面相关
extension TFPopPresentationController {

    ///设置蒙版
    func setupCoverView(){
        //1.添加HUD
        containerView?.insertSubview(coverView, at: 0)
        
        //2.设置HUD属性
        coverView.backgroundColor = UIColor(white: 0.5 , alpha: 0.2)
        coverView.frame = containerView!.bounds
        
        //3.添加手势
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(TFPopPresentationController.tapCoverView))
        coverView.addGestureRecognizer(tapGes)
    }
}

//MARK:- 事件监听
extension TFPopPresentationController{

    ///点击手势
    func tapCoverView(){
        presentedViewController.dismiss(animated: true, completion: nil)
        print("tapCoverView--点击")
    }
}




