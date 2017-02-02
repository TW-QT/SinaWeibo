//
//  TFUserAccountTool.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/10/2.
//  Copyright © 2016年 http://taofei.me All rights reserved.
//

import UIKit

class TFUserAccountViewModel {
    
    //MARK:- 将我们的类设计成单例
    static let shareInstance : TFUserAccountViewModel = TFUserAccountViewModel()
    
    
    //MARK:- 定义属性
    var account : TFUSerAccount?
    
    
    //MARK:- 计算属性
    var isLogin : Bool{
    
        if account == nil {
            return false
        }
        guard let _ = account?.access_token else {
            return false
        }
        guard let expiresDate = account?.expires_date else{
            return false
        }
        return expiresDate.compare(Date()) == ComparisonResult.orderedDescending
    }
    var accountPath : String {
        //获取沙盒路径
        let  accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("account.plist")
    }
    
    init() {
        //读取信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? TFUSerAccount
    }
}
