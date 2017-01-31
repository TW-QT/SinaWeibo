//
//  AppDelegate.swift
//  SinaWeibo
//
//  Created by 陶飞 on 2016/10/20.
//  Copyright © 2016年 TaoFei. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //设置tabBar全局颜色
        UITabBar.appearance().tintColor = UIColor.orange
        //设置navigationbar全局颜色
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        
        //测试网络请求

        TFNetworkTools.shareInstance.tf_request(methodType: .POST, URLString: "http://httpbin.org/post", parameters: ["name" : "taofei" ,"age" : 18]) { (result, error) in
            if error != nil{
            
                print("有错误")
                return
            }
            
            print("没有错误")
            print(result!)
        }
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

//MARK:- 整个项目中用到的方法

/// 自定义的打印调试信息的函数TFLog(),整个项目中可用。
func TFLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):(\(lineNum))-\(messsage)")
    #endif
}

