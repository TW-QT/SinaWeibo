//
//  TFHomeViewController.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/10/20.
//  Copyright © 2016年 http://taofei.me All rights reserved.
//

import UIKit
import SDWebImage

class TFHomeViewController: TFBaseViewController {
    
    
    
    //MARK:- 懒加载属性
    lazy var statusesArray : [TFStatusViewModel] = [TFStatusViewModel]()
    lazy var titleBtn :TFTitleButton = TFTitleButton()
    //注意：在闭包中如果使用当前对象的属性或者调用函数也需要在前面加上self
    //两个地方需要用self:1.如果在一个函数中出现了歧义；2.在闭包中使用当前对象的属性和函数
    lazy var popoverAnimator : TFPopoverAnimator = TFPopoverAnimator { [weak self](isPresented) in
        self?.titleBtn.isSelected = isPresented
    }
    
    
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
        //3.请求数据
        loadStatues()
    }
}


//MARK:- UI界面的设置
extension TFHomeViewController{

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
        
        //4.设置tableView
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
    }
}


//MARK:- 事件监听
extension TFHomeViewController{
    
    func titleBtnClick(){
        //1.改变按钮的状态
//        titleBtn.isSelected = !titleBtn.isSelected
        //2.创建控制器
        let popoverVC = TFPopoverViewController()
        //3.设置自定义转场
        popoverVC.modalPresentationStyle = .custom
        //4.设置转场代理
        popoverVC.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x: 100, y: 55, width: 180, height: 250)
        //5.弹出控制器
        TFLog("标题按钮点击事件")
        present(popoverVC, animated: true, completion: nil)
    }
}

//MARK:- 请求数据
extension TFHomeViewController{
    
    func loadStatues(){
        TFNetworkTools.shareInstance.loadStatues { (result, error) in
            //1.错误校验
            if error != nil {
                TFLog(error)
                return
            }
            //2.获取可选类型中的数据
            guard let resultArray = result else{
                TFLog("没有获取到首页中的微博数组")
                return
            }
            //3.遍历微博对应的字典
            for statuesDict in resultArray{
                let status = TFStatus(dict: statuesDict)
                let viewModel = TFStatusViewModel(status: status)
                self.statusesArray.append(viewModel)
            }
            
            //4.缓存图片
            self.cacheImage(viewModels: self.statusesArray)
            
            
            
            
        }
    }
    
    
    ///缓存图片
    func cacheImage(viewModels :[TFStatusViewModel]){
        
        //0.创建group
        let group = DispatchGroup()
        
        //1.缓存图片
        for viewModel in viewModels {
            for picURL in viewModel.picURLs {
                group.enter()
                SDWebImageManager.shared().downloadImage(with: picURL, options: [], progress: nil, completed: { (_, _, _, _, _) in
                    //到此下载了一张图片
                    group.leave()
                })
            }
        }
        
        group.notify(queue: .global()) { 
            //2.刷新表格
            self.tableView.reloadData()
        }
    }
}



//MARK:- tableView的数据源和代理方法
extension TFHomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1.创建cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellID")! as! TFHomeViewCell
        
        //2.给cell设置数据
        cell.viewModel = statusesArray[indexPath.row]
        return cell
    }


}




