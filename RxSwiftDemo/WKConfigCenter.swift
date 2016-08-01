//
//  ConfigCenter.swift
//  RxSwiftDemo
//
//  Created by 孟辉 on 16/7/20.
//  Copyright © 2016年 孟辉. All rights reserved.
//

let  kUMkey = "578ed61a67e58e862d000584"
//
let  kWXAppId = ""
let  kWXAppSecret = ""
let  kWXUrl = "http://www.umeng.com/social"

//
let  kQQAppId = ""
let  kQQAppSecret = ""
let  kQQUrl = "http://www.umeng.com/social"
//
let  kWeiboAppId = "1394974730"
let  kWeiboAppSecret = "495fd651f61961b3a974345bf9883fe2"
let  kWeiboUrl = "https://api.weibo.com/oauth2/default.html"//"http://sns.whalecloud.com/sina2/callback"
import Foundation
import RxSwift

class WKConfigCenter  {
  /*  class func setUMAppKeyAndOtherThirdEvent() -> () {
       
        UMSocialData.setAppKey(kUMkey)
        //UMSocialWechatHandler.setWXAppId(kWXAppId, appSecret:kWXAppSecret, url: kWXUrl)
    
       // UMSocialQQHandler.setQQWithAppId(kQQAppId, appKey:kQQAppSecret, url: kQQUrl)
        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey(kSinaAppId, secret: kSinaAppSecret, redirectURL: kSinaUrl)
        UMSocialDataService.defaultDataService().requestUnOauthWithType(UMShareToSina) { (response) in
            print("response is %@",response);
        }
    }
 */
    static var shareCenter = WKConfigCenter()
    private init(){
    
    }
     var weiboUserId = Variable("")
     var weiboAccessToken = Variable("")
     class func setSinaWeiboAppKey(){
    
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(kWeiboAppId)
    
    }
    
    
    
    var userDetail:UserConvertible? //登陆的用户
    
    
    
    
    
    
    
    
}