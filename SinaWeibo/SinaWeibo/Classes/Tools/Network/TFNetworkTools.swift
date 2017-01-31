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
    
    
    ///发送GET或者POST网络请求的封装
    func tf_request(methodType : TFRequestType, URLString : String,parameters :[String : Any?],finished :@escaping (_ reslut :Any? ,_ error : Error?)->()){
        
        
        //1.定义请求成功的回调
        let successCallBack = { (task : URLSessionDataTask, result :Any?) in
            finished(result,nil)
        }
        
        //2.定义请求失败的回调
        let failureCallBack = { (task : URLSessionDataTask?, error : Error) in
            finished(nil, error)
        }
    
        //3.发送网络请求
        if methodType == .GET {//GET请求
            get(URLString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }else if methodType == .POST{//POST请求
            post(URLString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    }
}




//            get(URLString, parameters: parameters, progress: nil, success: { (task : URLSessionDataTask, result :Any?) in
//                print("发送网络请求成功~")
//                print(result as Any)
//                //回调
//                finished(result,nil)
//            }) { (task : URLSessionDataTask?, error : Error) in
//                print("发送网络请求失败")
//                print(error)
//                //回调
//                finished(nil, error)
//            }




//            post(URLString, parameters: parameters, progress: nil, success: { (task : URLSessionDataTask, result : Any?) in
//                print("发送网络请求成功~")
//                print(result as Any)
//                //回调
//                finished(result,nil)
//            }) { (task : URLSessionDataTask?, error : Error) in
//                print("发送网络请求失败")
//                print(error)
//                //回调
//                finished(nil, error)
//            }
