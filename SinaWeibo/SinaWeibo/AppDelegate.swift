//
//  AppDelegate.swift
//  SinaWeibo
//
//  Created by Donkey-Tao on 2016/08/20.
//  Copyright © 2016年 http://taofei.me All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var defaultViewController :UIViewController? {
        let isLogin = TFUserAccountViewModel.shareInstance.isLogin
        return isLogin ? TFWelcomeViewController() : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //设置tabBar全局颜色
        UITabBar.appearance().tintColor = UIColor.orange
        //设置navigationbar全局颜色
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        
        //创建window
        window =  UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = defaultViewController
        window?.makeKeyAndVisible()

        print(TFUserAccountViewModel.shareInstance.account?.access_token)
        
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

