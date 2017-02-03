//
//  TFStatusViewModel.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/10/3.
//  Copyright © 2016年 http://taofei.me All rights reserved.
//

import UIKit

class TFStatusViewModel: NSObject {
    //MARK:- 定义属性
    var status : TFStatus?
    
    
    //MARK:- 对数据处理的属性
    var source_text : String?           //处理来源
    var created_at_text : String?       //处理创建时间
    var verifiedImage :UIImage?         //处理用户认证图标
    var vipImage :UIImage?              //处理用户等级
    
    //MARK:- 自定义构造函数
    init(status : TFStatus) {
        self.status = status
        //1.对来源信息进行处理
        if let source = status.source, status.source != "" {//1.1空值校验
            //1.2对来源的字符串进行处理
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            source_text = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
        //2.对时间的处理
        if let created_at = status.created_at {//2.1nil值校验
            //2.2对时间进行处理
            created_at_text = Date.createDateString(created_at)
        }
        //3.处理认证
        let verified_type = status.user?.verified_type ?? -1
        switch verified_type {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2,3,5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        //4.处理会员图标
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
    }
}

