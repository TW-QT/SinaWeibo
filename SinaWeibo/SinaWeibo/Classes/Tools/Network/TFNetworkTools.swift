//
//  TFNetworkTools.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2017/1/31.
//  Copyright © 2017年 http://taofei.me All rights reserved.
//


import AFNetworking

//定义枚举类型
enum TFRequestType : String{
    case GET = "GET"
    case POST = "POST"
}

class TFNetworkTools: AFHTTPSessionManager {
    
    //let是线程安全的
    static let shareInstance : TFNetworkTools = {
        let tools = TFNetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tools
    }()
}


//MARK:- 封装请求方法
extension TFNetworkTools{

    func tf_getRequest(methodType : TFRequestType, URLString : String,parameters :[String : Any?]){
    
        if methodType == .GET {
            get(URLString, parameters: parameters, progress: nil, success: { (task : URLSessionDataTask, result :Any?) in
                print("发送网络请求成功~")
                print(result as Any)
            }) { (task : URLSessionDataTask?, error : Error) in
                print("发送网络请求失败")
                print(error)
            }
        }else if methodType == .POST{
            post(URLString, parameters: parameters, progress: nil, success: { (task : URLSessionDataTask, result : Any?) in
                print("发送网络请求成功~")
                print(result as Any)
            }) { (task : URLSessionDataTask?, error : Error) in
                print("发送网络请求失败")
                print(error)
            }
        }
    }
}
