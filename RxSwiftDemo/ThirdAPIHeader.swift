//
//  ThirdAPIHeader.swift
//  RxSwiftDemo
//
//  Created by 孟辉 on 16/7/20.
//  Copyright © 2016年 孟辉. All rights reserved.
//

/*
 新浪
 URL:https://api.weibo.com/oauth2/authorize
 HTTP请求方式:GET/POST
 请求参数:  client_id 	    true 	string 	申请应用时分配的AppKey。
          redirect_uri   	true 	string 	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
          scope 	        false 	string 	申请scope权限所需参数，可一次申请多个scope权限，用逗号分隔。使用文档
          state 	        false 	string 	用于保持请求和回调的状态，在回调时，会在Query Parameter中回传该参数。开发者可以用这个参数验证请求有效性，也可以记录用户请求授权页前的位置。这个参数可用于防止跨站请求伪造（CSRF）攻击
          display 	        false 	string 	授权页面的终端类型，取值见下面的说明。
          forcelogin 	    false 	boolean 	是否强制用户重新登录，true：是，false：否。默认false。
          language 	        false 	string 	授权页语言，缺省为中文简体版，en为英文版。英文版测试中，开发者任何意见可反馈至 @微博API
 
*/
let kWeiboAPIAuthorizeUrl = "https://api.weibo.com/oauth2/authorize"
let kWeiboAPIkeyClient_Id = "client_id"
let kWeiboAPIkeyRedirect_Uri = "redirect_uri"

let kWeiboAPIUsersUrl = "https://api.weibo.com/2/users/show.json"
let kWeiboAPIkeyAccess_Token  = "access_token"
let kWeiboAPIkeyUid = "uid"
