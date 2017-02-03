//
//  TFStatus.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/10/2.
//  Copyright © 2017年 http://taofei.me All rights reserved.
//

import UIKit

class TFStatus: NSObject {
    
    //MARK:- 属性
    var created_at : String?        //微博创建时间
    var source : String?            //微博来源
    var text : String?              //微博正文
    var mid : Int = 0               //微博的ID
    var user : TFUser?              //微博发布者

    
    //MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        //将用户字典转为用户模型对象
        if let userDict = dict["user"] as? [String:Any]{
            user = TFUser(dict: userDict)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
