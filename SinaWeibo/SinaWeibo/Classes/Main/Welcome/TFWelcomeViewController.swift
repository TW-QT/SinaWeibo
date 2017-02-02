//
//  TFWelcomeViewController.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/10/2.
//  Copyright © 2016年 http://taofei.me. All rights reserved.
//

import UIKit
import SDWebImage

class TFWelcomeViewController: UIViewController {

    //MARK:- 拖线的属性
    @IBOutlet weak var avatarViewBottomConstant: NSLayoutConstraint!
    @IBOutlet weak var avatarView: UIImageView!
    
    
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //0.设置头像
        let ProfileAvatarURLString = TFUserAccountViewModel.shareInstance.account?.avatar_large
        //??:如果前面的可选类型有值，将其解包，如果为nil，就使用？？后面的值
        let url =  URL(string: ProfileAvatarURLString ?? "")
        avatarView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        //1.改变约束的值
        avatarViewBottomConstant.constant = UIScreen.main.bounds.size.height - 200
        //2.执行动画
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }

    }
}
