//
//  AppDelegate.swift
//  Qinghuairili
//
//  Created by 呉　秋平 on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navVC: UINavigationController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.navVC = UINavigationController(rootViewController: MainVC(nibName: "MainVC", bundle: nil))
        self.navVC.navigationBarHidden = true
        self.window!.rootViewController = self.navVC
        self.window!.makeKeyAndVisible()
        //Framework
        WQPSetting.registKey()
        WQPShare.initShareSDK()
        //Style
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        sleep(1)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
}
