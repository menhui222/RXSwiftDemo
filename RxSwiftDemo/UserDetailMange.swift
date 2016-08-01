//
//  UserDetailMange.swift
//  RxSwiftDemo
//
//  Created by 孟辉 on 16/7/21.
//  Copyright © 2016年 孟辉. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol UserConvertible{

    
    var userNmae :String { get }
    
    var id :String { get }
    
    var avatar_hd:String{get}
    
    
}

class SinaUserDetail :UserConvertible,ObjectJSONConvertType{

    var userNmae: String = ""
    var id :String = ""
    var avatar_hd:String = ""
    
    init(json:JSON){
    print(json.count)
       userNmae = json["name"].string ?? "微博小朋友"
        id = "weibo" + (json["id"].string ?? "")
        avatar_hd = json["avatar_hd"].string ?? ""
    }
    static func getSelf(json:JSON) throws -> ObjectJSONConvertType{
        let obj = SinaUserDetail(json:json)
        return obj
    }
}
