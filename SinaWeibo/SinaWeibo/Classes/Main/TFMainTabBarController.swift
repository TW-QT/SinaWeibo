//
//  TFMainTabBarController.swift
//  SinaWeibo
//
//  Created by 陶飞 on 2016/10/20.
//  Copyright © 2016年 TaoFei. All rights reserved.
//

import UIKit

class TFMainTabBarController: UITabBarController {
    
    
    //MARK:- 懒加载属性
    lazy var composeBtn :UIButton = UIButton()
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置发布按钮
        setupComposeBtn()
    }
    

}

//MARK:- 设置UI界面
extension TFMainTabBarController{

    /// 设置发布按钮
    func setupComposeBtn(){
        //1.将composeBtn添加到tabBar中
        tabBar.addSubview(composeBtn)
        //2.设置属性
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        composeBtn.sizeToFit()
        //3.设置位置
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height*0.5)
        //4.监听按钮点击
        composeBtn.addTarget(self, action: #selector(TFMainTabBarController.composeBtnClick), for: .touchUpInside)
        
    }
}

//MARK:- 发布按钮的点击
extension TFMainTabBarController{
    
    func composeBtnClick(){
    
        print("composeBtnClick--")
    
    }


}


