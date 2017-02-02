//
//  TFUSerAccount.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/10/1.
//  Copyright © 2016年 http://taofei.me. All rights reserved.
//

import UIKit

class TFUSerAccount: NSObject,NSCoding {
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
    
    
    
    //MARK:- 归档和解档
    //解档
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    
    //归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
    
    
    
    
    
    
    
    
}
