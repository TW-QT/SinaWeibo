//
//  TFOAuthViewController.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/10/1.
//  Copyright © 2016年 http://taofei.me. All rights reserved.
//

import UIKit
import SVProgressHUD

class TFOAuthViewController: UIViewController {
    
    //MARK:- 属性
    @IBOutlet weak var OAuthLoginWebView: UIWebView!
    
    
    //MARK:- 系统回调函数

    override func viewDidLoad() {
        super.viewDidLoad()

        //1.设置导航栏的内容
        setupNavigationBar()
        //2.加载网页
        loadOAuthWebView()
    }

}



//MARK:- 设置UI界面
extension TFOAuthViewController{

    ///设置导航条
    func setupNavigationBar(){
        //1.设置左边的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(TFOAuthViewController.closeItemClick))
        
        //2.设置右边的Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(TFOAuthViewController.fillItemClick))
        
        //3.设置标题
        title = "登录页面"
    }
    
    
    ///加载授权登录页面
    func loadOAuthWebView(){
        //1.获取登录页面的URLString
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        //2.创建对应的NSURL
        guard let url = NSURL(string: urlString)else{
            return
        }
        
        //3.创建NSURLRequest对象
        let request = NSURLRequest(url: url as URL)
        
        //4.加载request对象
        OAuthLoginWebView.loadRequest(request as URLRequest)
    }
}


//MARK:- 事件监听
extension TFOAuthViewController{

    ///关闭
    @objc func closeItemClick(){
    
        dismiss(animated: true, completion: nil)
    }
    
    ///填充
    @objc func fillItemClick(){
        //1.书写JavaScript代码
        let jsCode = "document.getElementById('userId').value='745838164@qq.com';document.getElementById('passwd').value='feit0610weibo16'"
        //2.执行JavaScript代码
        OAuthLoginWebView.stringByEvaluatingJavaScript(from: jsCode)
    }
}


//MARK:- webView的代理方法
extension TFOAuthViewController : UIWebViewDelegate{

    ///开始加载webView网页
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    ///结束加载webView网页
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    ///网页加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    ///当准备加载某一个页面时会执行该方法，其返回值时Bool类型；true,继续加载，false,不会继续加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //1.获取加载网页的URL
        guard let url = request.url else{
            return true
        }
        //2.获取url中的字符串
        let urlString = url.absoluteString
        //3.判断该字符串中是否包含code
        guard urlString.contains("code=") else{
            return true
        }
        //4.将code截取出来
        let code = urlString.components(separatedBy: "code=").last!
        //5.请求AccessToken
        getAccessToken(code: code)
        return false
    }
}

//MARK:- 请求数据
extension TFOAuthViewController{

    ///请求AccessToken
    @objc func getAccessToken(code : String){
        
        TFNetworkTools.shareInstance.getAccessToken(code: code) { (result, error) in
            //1.错误校验
            if error != nil{
                TFLog(error)
                return
            }
            //2.拿到结果
            guard let accountDict =  result else{
                TFLog("没有获取到授权后的数据")
                return
            }
            //3.将字典转为模型对象
            let account = TFUSerAccount(dict: accountDict)
            //4.请求用户信息(在闭包里面调用当前对象的某一个方法要用self)
            self.loadUserInfo(account: account)
        }
    }
    
    
    ///请求用户信息
    func loadUserInfo(account : TFUSerAccount){
    
        //1.获取access_token
        guard let access_token = account.access_token else {
            return
        }
        //2.获取uid
        guard let uid = account.uid else {
            return
        }
        //3.发送网络请求
        TFNetworkTools.shareInstance.loadUserInfo(access_token: access_token, uid: uid) { (result, error) in
            //1.错误校验
            if error != nil {
                TFLog("获取用户信息网络请求错误.")
                return
            }
            //2.用户信息字典的校验
            guard let userInfoDict = result else{
                return
            }
            //3.从字典中取出昵称和头像地址
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            //4.将account进行保存
            //4.1获取沙盒路径
            var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true).first!
            accountPath = (accountPath as NSString).appendingPathComponent("account.plist")
            NSKeyedArchiver.archiveRootObject(account, toFile: accountPath)
            
        }
    }
}

