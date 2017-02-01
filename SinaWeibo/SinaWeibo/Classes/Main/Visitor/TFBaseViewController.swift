//
//  TFBaseViewController.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2017/1/27.
//  Copyright © 2017年 taofei.me. All rights reserved.
//

import UIKit

class TFBaseViewController: UITableViewController {
    
    //MARK:- 懒加载属性
    lazy var visitorView : TFVisitorView = TFVisitorView.TFVisitorView()
    
    //MARK:- 定义是否已经登录状态变量
    var isLogin :Bool = false
    
    
    
    //MARK:- 重写系统回调函数
    /// 重写加载View的方法
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItem()
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


//MARK:- 设置UI
extension TFBaseViewController{
    
    ///设置访客视图
    func setupVisitorView() {
        view = visitorView
        //监听访客视图中的注册、登录按钮的点击
        visitorView.registerBtn.addTarget(self, action: #selector(TFBaseViewController.registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(TFBaseViewController.loginBtnClick), for: .touchUpInside)
    }
    
    ///设置导航栏左右的注册、登录按钮
    func setupNavigationItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain , target: self, action:#selector(TFBaseViewController.registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain , target: self, action:#selector(TFBaseViewController.loginBtnClick))
    
    }
}

//MARK:- 时间监听
extension TFBaseViewController{
    
    
    ///注册按钮点击
    @objc func registerBtnClick(){
        
        TFLog("注册按钮点击")
    }
    ///登录按钮点击
    @objc func loginBtnClick(){
        //1.创建授权控制器
        let oauthVC = TFOAuthViewController()
        //2.包装一个导航控制器
        let oauthNavVC = UINavigationController(rootViewController: oauthVC)
        
        //3.弹出控制器
        present(oauthNavVC, animated: true, completion: nil)
    
        TFLog("登录按钮点击")
    }


}



