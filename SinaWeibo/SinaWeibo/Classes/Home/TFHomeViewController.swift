//
//  TFHomeViewController.swift
//  SinaWeibo
//
//  Created by 陶飞 on 2016/10/20.
//  Copyright © 2016年 TaoFei. All rights reserved.
//

import UIKit

class TFHomeViewController: TFBaseViewController {
    
    //MARK:- 是否为弹出动画
    var isPresented : Bool = false
    
    //MARK:- 懒加载属性
    lazy var titleBtn :TFTitleButton = TFTitleButton()
    
    
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
        popoverVC.transitioningDelegate = self
        //5.弹出控制器
        TFLog("标题按钮点击事件")
        present(popoverVC, animated: true, completion: nil)
    }
}

//MARK:- 自定义转场动画代理方法的实现
extension TFHomeViewController : UIViewControllerTransitioningDelegate{
    
    //目的：改变frame
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return TFPopPresentationController(presentedViewController: presented, presenting: presenting)
    }
    //目的：自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    //目的：自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}


//MARK:- 弹出或者消失动画代理方法的实现
extension TFHomeViewController : UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    
    //获取转场的上下文:可以通过上下文获取弹出的View和消失的View
    //UITransitionContextViewKey.from:获取消失的View
    //UITransitionContextViewKey.to:获取弹出的View
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isPresented ? animationForPresentedView(using: transitionContext) : animationForDismissedView(using: transitionContext)
    }

    ///弹出动画
    func animationForPresentedView(using transitionContext: UIViewControllerContextTransitioning){
        //1.获取弹出的View
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        //2.自定义转场:将弹出的View添加到ContainerView中;
        transitionContext.containerView.addSubview(presentedView)
        //3.执行动画
        //设置锚点
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        presentedView.transform = CGAffineTransform(scaleX: 1.0 , y: 0.0)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            
            presentedView.transform = CGAffineTransform.identity
        }) { (_) in
            //必须告诉上下文已经完成了动画
            transitionContext.completeTransition(true)
        }
    }
    
    ///消失动画
    func animationForDismissedView(using transitionContext: UIViewControllerContextTransitioning){
    
        //1.获取消失的View
        let dismissedView = transitionContext.view(forKey: UITransitionContextViewKey.from)!

        //2.执行动画
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            
            dismissedView.transform = CGAffineTransform(scaleX: 1.0 , y: 0.0001)
        }) { (_) in
            dismissedView.removeFromSuperview()
            //必须告诉上下文已经完成了动画
            transitionContext.completeTransition(true)
        }
    }
}



