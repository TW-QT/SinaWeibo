//
//  TFNetworkTools.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/09/31.
//  Copyright © 2016年 http://taofei.me All rights reserved.
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
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
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


//MARK:- 请求AccessToken
extension TFNetworkTools{
    
    func getAccessToken(code : String,finished :@escaping (_ result : [String : Any]?, _ error : Error?)->()){
        //1.获取请求的URL
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        //2.获取请求的参数
        let params = ["client_id":app_key , "client_secret":app_secret ,"grant_type":"authorization_code" , "redirect_uri":redirect_uri, "code":code]
        
        //3.发送请求
        tf_request(methodType: .POST, URLString: urlString, parameters: params) { (result, error) in
            finished(result as? [String : Any], error)
        }
    }
}


//MARK:- 请求用户信息
extension TFNetworkTools{
    func loadUserInfo(access_token : String, uid: String,finished :@escaping (_ result : [String :Any]?,_ error : Error?)->()){
        //1.获取请求的URL
        let urlString : String = "https://api.weibo.com/2/users/show.json"
        //2.获取请求参数
        let params : Dictionary = ["access_token" : access_token , "uid" : uid]
        //3.发送网络请求
        tf_request(methodType: .GET, URLString: urlString, parameters: params) { (result, error) in
            finished(result as? [String : Any], error)
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




//测试网络请求

//TFNetworkTools.shareInstance.tf_getRequest(methodType: .POST, URLString: "http://httpbin.org/post", parameters: ["name" : "taofei" ,"age" : 18]) { (result, error) in
//    if error != nil{
//        
//        print("有错误")
//        return
//    }
//    
//    print("没有错误")
//    print(result!)
//}
        
