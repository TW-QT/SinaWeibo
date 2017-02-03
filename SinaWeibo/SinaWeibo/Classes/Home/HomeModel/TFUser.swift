//
//  TFUser.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/10/3.
//  Copyright © 2016年 http://taofei.me All rights reserved.
//

import UIKit

class TFUser: NSObject {
    //MARK:- 属性
    var profile_image_url : String?             //用户头像
    var screen_name : String?                   //用户昵称
    var verified_type :Int = -1                 //用户认证类型
    var mbrank : Int = 0                        //用户会员等级
    
    
    
    //MARK:- 自定义构造函数
    init(dict : [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
