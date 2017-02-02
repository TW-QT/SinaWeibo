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
    var source : String?{           //微博来源
        didSet{
            //1.空值校验
            guard let source = source, source != "" else{
                return
            }
            //2.对来源的字符串进行处理
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            source_text = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
    }
    var text : String?              //微博正文
    var mid : Int = 0               //微博的ID
    
    
    //MARK:- 处理过的属性信息
    var source_text : String?
    
    
    //MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
