//
//  AppDelegate.swift
//  RxSwiftDemo
//
//  Created by 孟辉 on 16/4/15.
//  Copyright © 2016年 孟辉. All rights reserved.
//

import UIKit
let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        WKConfigCenter.setSinaWeiboAppKey()
       
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return WeiboSDK.handleOpenURL(url, delegate: self)
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return WeiboSDK.handleOpenURL(url, delegate: self)
    }


}
extension AppDelegate: WeiboSDKDelegate{

    func didReceiveWeiboRequest(request: WBBaseRequest!) {
        
    }
    func didReceiveWeiboResponse(response: WBBaseResponse!) {
        print(response)
        
        guard  let res = response as? WBAuthorizeResponse else{
            return
        }
            
        guard let userId = res.userID else{
            return
        }
        guard let accessToken = res.accessToken else{
            return
        }
        
        print(userId,accessToken)
        WKConfigCenter.shareCenter.weiboUserId.value = userId;
        WKConfigCenter.shareCenter.weiboAccessToken.value = accessToken;

        
        
    }


}

