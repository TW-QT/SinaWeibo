//
//  TFHomeViewController.swift
//  SinaWeibo
//
//  Created by 陶飞 on 2016/10/20.
//  Copyright © 2016年 TaoFei. All rights reserved.
//

import UIKit

class TFHomeViewController: TFBaseViewController {
    
    
    
    //MARK:- 懒加载属性
    lazy var titleBtn :TFTitleButton = TFTitleButton()
    lazy var popoverAnimator : TFPopoverAnimator = TFPopoverAnimator()
    
    
    //MARK:- 系统回调函数
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //1.没有登录的内容
        //没有登录情况下转盘动画的设置
        visitorView.addRotationViewAnimation()
        //如果没有登录就不执行下面首页的相关内容
        if !isLogin{
            return
        }
        //2.设置导航栏的内容
        setupNavigationBar()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}


//MARK:- UI界面的设置
extension   TFHomeViewController{

    ///设置导航栏
    func setupNavigationBar(){
    
    
        //1.设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        
        //2.设置右侧的item
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        //3.设置titleView
        titleBtn.setTitle("Donkey-Tao", for: .normal)
        titleBtn.addTarget(self, action: #selector(TFHomeViewController.titleBtnClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}


//MARK:- 事件监听
extension TFHomeViewController{
    
    func titleBtnClick(){
        //1.改变按钮的状态
        titleBtn.isSelected = !titleBtn.isSelected
        //2.创建控制器
        let popoverVC = TFPopoverViewController()
        //3.设置自定义转场
        popoverVC.modalPresentationStyle = .custom
        //4.设置转场代理
        popoverVC.transitioningDelegate = popoverAnimator
        //5.弹出控制器
        TFLog("标题按钮点击事件")
        present(popoverVC, animated: true, completion: nil)
    }
}




