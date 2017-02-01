//
//  TFUSerAccount.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2017/2/1.
//  Copyright © 2017年 http://taofei.me. All rights reserved.
//

import UIKit

class TFUSerAccount: NSObject {
    //MARK:- 属性
    ///授权access_token
    var access_token : String?
    ///过期时间，秒
    var expires_in : TimeInterval = 0.0 {
        didSet{
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    ///用户ID
    var uid : String?
    ///过期日期（）
    var expires_date : Date?
    ///昵称
    var screen_name : String?
    ///用户的头像地址
    var avatar_large : String?
    
    //MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
    //MARK:- 重写函数
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    //MARK:- 重写description
    override var description: String{
        return dictionaryWithValues(forKeys: ["access_token","expires_date","uid","screen_name","avatar_large"]).description
    }
}
