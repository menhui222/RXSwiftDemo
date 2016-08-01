//
//  LoginViewModel.swift
//  RxSwiftDemo
//
//  Created by 孟辉 on 16/6/20.
//  Copyright © 2016年 孟辉. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBlocking
import Alamofire
import SwiftyJSON

let minUsernameLength = 5
let maxUsernameLength = 10
let minPasswordLength = 5
let maxPasswordLength = 16


class LoginViewModel:NSObject{

    
    var userNameValid:Observable<Bool>
    var passwordValid:Observable<Bool>
    
    var loginEnable:Observable<Bool>
    
    var sinaLogin:Observable<Bool>
    var sinaAction:Observable<Result<UserConvertible>>
    var qqlogin:Observable<Bool>
    var weChatlogin:Observable<Bool>
   // var loginSuccess : Variable<Bool>
    let loginIn: Observable<Bool>
    init(input:(
        vc:UIViewController,
        userName:Observable<String>,
        password:Observable<String>,
        loginTap:Observable<Void>,
        qqTap:Observable<Void>,
        weboTap:Observable<Void>,
        weChatTap:Observable<Void>
        )){
    
        
        //用户
        userNameValid = input.userName.replay(1).map({ (userName) -> Bool in
            return  (userName.characters.count > minUsernameLength&&userName.characters.count < maxUsernameLength)
        })
        // 密码
        passwordValid = input.password.replay(1).map({ (password) -> Bool in
            return  (password.characters.count > minPasswordLength&&password.characters.count < maxPasswordLength)
        })
        // 是否登录
        loginEnable = Observable.combineLatest(userNameValid, passwordValid) { (userName, password) -> Bool  in
            
            return (userName&&password)
        }
        //loginSuccess = Variable(false)
        
        
       let usernameAndPassword = Observable.combineLatest(input.userName, input.password) {
            ($0,$1)
        }
    
      loginIn = input.loginTap.withLatestFrom(usernameAndPassword).flatMapLatest{ (userName,password) -> Observable<Bool> in
        return Observable<Bool>.create({ (subscribe) -> Disposable in
        
            let delayInSeconds = 1.0
            let popTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(delayInSeconds * Double(NSEC_PER_SEC))) // 1
            dispatch_after(popTime, dispatch_get_main_queue(), {
                subscribe.onNext((userName.characters.count>0&&password.characters.count>0))
                subscribe.onCompleted()
            })
        
            return NopDisposable.instance
        })
      }
    
//        func anonymousErrorCatch(response: Response<AnyObject, NSError>) throws -> AnyObject{
//            if let _ = response.result.error{
//                print(response.result.error)
//                throw IaskuErrorType.NoNetwork//NSError(domain: "网络连接失败", code: -1, userInfo: nil)
//            }
//            guard let json = response.result.value else{
//                throw IaskuErrorType.NoData//NSError(domain: "接口返回数据为空", code: -1, userInfo: nil)
//            }
//            print(json)
//            return json
//        }
        sinaLogin  =  input.weboTap.flatMapLatest { () ->Observable<Bool>  in
            return Observable<Bool>.create({ (subscribe) -> Disposable in
                
                /*
                 //友盟不支持swift
                let socialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina) as UMSocialSnsPlatform
                socialSnsPlatform.loginClickHandler!(input.vc,UMSocialControllerService.defaultControllerService(),true ,{(response) in
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        
                        let dict = UMSocialAccountManager.socialAccountDictionary()
                        guard let snsAccount = dict[socialSnsPlatform.platformName]else{
                            subscribe.onNext(false)
                            return
                        }
                        print("\nusername = \(snsAccount.userName),\n usid =  \(snsAccount.userName),\n token =  \(snsAccount.userName) iconUrl =  \(snsAccount.userName),\n unionId =  \(snsAccount.userName),\n thirdPlatformUserProfile =  \(snsAccount.userName),\n thirdPlatformResponse =  \(snsAccount.userName) \n, message = ",snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message)
                      subscribe.onNext(true)
                        
                    }
                    })
                 */
//                Alamofire.request(.GET, kWeiboAPIUrl, parameters: [kWeiboAPIkeyClient_Id:kWeiboAppId,kWeiboAPIkeyRedirect_Uri:kWeiboUrl]).responseJSON(completionHandler: { response -> Void in
//                    do{
//                        let objc = try anonymousErrorCatch(response)
//                        
//                    
//                    }catch{
//                    
//                    }
//                })
                
                let request = WBAuthorizeRequest.request() as! WBAuthorizeRequest
               
                request.redirectURI = kWeiboUrl;
                request.scope = "all";
                request.userInfo = ["SSO_From": "SendMessageToWeiboViewController",
                    "Other_Info_1": 123,
                    "Other_Info_2": ["obj1", "obj2"],
                    "Other_Info_3": ["key1": "obj1", "key2": "obj2"]];
                WeiboSDK.sendRequest(request)
                
                
                subscribe.onNext(true)
                
                return NopDisposable.instance
            })
        }
        

       //https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",accessToken,uid
     sinaAction =   Observable.combineLatest(WKConfigCenter.shareCenter.weiboUserId.asObservable().skip(1), WKConfigCenter.shareCenter.weiboAccessToken.asObservable().skip(1), resultSelector:{($0, $1)}).flatMapLatest { (userID, accessToken) -> Observable<Result<UserConvertible>> in
//        
//            return Observable<Result<UserConvertible>>.create({ (subscribe) -> Disposable in
//               
//                Alamofire.request(.GET, kWeiboAPIUsersUrl, parameters: [kWeiboAPIkeyUid:userID,kWeiboAPIkeyAccess_Token:accessToken]).responseJSON(completionHandler: { response -> Void in
//                do{
//                    let objc = try anonymousErrorCatch(response)
//                    
//                       let json = JSON(objc)
//                   let userDetail = SinaUserDetail(json: json)
//                    WKConfigCenter.shareCenter.userDetail = userDetail
//                    subscribe.onNext(Result.Success(userDetail))
//                }catch(let errorType){
//                    subscribe.onNext(Result.Failure(errorType))
//                }
//            })
//            
//                return NopDisposable.instance
//            })
        
           return Alamofire.request(.GET, kWeiboAPIUsersUrl, parameters: [kWeiboAPIkeyUid:userID,kWeiboAPIkeyAccess_Token:accessToken]).responseJSON().map({ (result) -> Result<UserConvertible> in
            //本来想把解析封装进去的 原谅我出现了一小点点问题，我无法解决的问题
            //extension Observable where Element : Result<JSON>  对Observable<Observable>进行extension怎么实现
                switch result{
                case Result.Success(let json) :
                    let userDetail = SinaUserDetail(json: json)
                     WKConfigCenter.shareCenter.userDetail = userDetail
                    return Result.Success(userDetail)
                case  Result.Failure(let errorType):
                    return Result.Failure(errorType)
                    
                    
                }

           })

        }
        
       
        
        
        
        qqlogin =  input.qqTap.flatMapLatest { () ->Observable<Bool>  in
            return Observable<Bool>.create({ (subscribe) -> Disposable in
                subscribe.onNext(true)
                //集成 QQ登录
                return NopDisposable.instance
            })
        }
        weChatlogin  =  input.weChatTap.flatMapLatest { () ->Observable<Bool>  in
            return Observable<Bool>.create({ (subscribe) -> Disposable in
                subscribe.onNext(true)
                
                return NopDisposable.instance
            })
        }
        
        
       
        
        
    }
    
    
    
    
}
