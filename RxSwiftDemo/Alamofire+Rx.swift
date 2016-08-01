//
//  Alamofire+Rx.swift
//  RxSwiftDemo
//
//  Created by 孟辉 on 16/7/21.
//  Copyright © 2016年 孟辉. All rights reserved.
//

import Alamofire
import RxSwift
import SwiftyJSON

enum Result<T>  {
    case Success(T)
    case Failure(ErrorType)
}
//enum IaskuErrorType :ErrorType { case NoNetwork,NoData, ParsingError }//发现 还是下面那个FailureType好用
enum FailureType:ErrorType {
    case Failed(message: String,code:Int)
    
    var message : String{
        if case  .Failed(let m, _) = self{
            return m
        }else{
            return ""
        }
    }
}
//单个对象解析
protocol ObjectJSONConvertType {
    static func getSelf(json:JSON) throws -> ObjectJSONConvertType
}
//list解析成数组<object>
protocol ListJSONConvertType {
    static func getSelfList(json:JSON) throws -> [ListJSONConvertType]
}

extension Request {
    func responseJSON()-> Observable<Result<JSON>> {
        func anonymousErrorCatch(response: Response<AnyObject, NSError>) throws -> AnyObject{
            if let _ = response.result.error{
                print(response.result.error)
                throw FailureType.Failed(message: "网络连接失败", code: -1)
                //IaskuErrorType.NoNetwork
                //NSError(domain: "网络连接失败", code: -1, userInfo: nil)
            }
            guard let dic = response.result.value else{
                throw FailureType.Failed(message: "返回数据为空", code: -1)
                //IaskuErrorType.NoData
                //NSError(domain: "接口返回数据为空", code: -1, userInfo: nil)
            }
            print(dic)
            return dic
        }

        return Observable<Result<JSON>>.create({ (o) -> Disposable in
            print("===============请求开始================")
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            self.responseJSON { (res) -> Void in
                defer{
                    print(res.request?.URLString)
                    print(res.timeline)
                    print(res.request?.allHTTPHeaderFields)
                    if let body = res.request?.HTTPBody{
                        print(String(data: body, encoding: NSUTF8StringEncoding))
                    }
                    print(res.result.value)
                    print("===============请求结束================")
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
                do{
                    let  result = try anonymousErrorCatch(res)
                    let json = JSON(result)
                    o.onNext(Result.Success(json))
                    
                    
                }catch(let errorType){
                     o.onNext(Result.Failure(errorType))
                }
            }
            
            
            return AnonymousDisposable{
                self.cancel()
            }
        })
    }
  
    
}
/*
extension Observable where Element : Request{

    func responseModel<M:ObjectJSONConvertType>(type:M.Type)->Observable<Result<M>>{
        return self.flatMap({ (request) -> Observable<Result<M>>  in
           return request.responseJSON().parsingToObject(type)
            
        })
    }
    

    
}
 */




/*
extension Observable where Element : Result<JSON>{

     func parsingToObject<M:ObjectJSONConvertType>(type:M.Type) -> Observable<Result<M>>{
        return self.flatMap({ (result) -> Result<M> in
            switch self{
            case Success(let json) :
                let obj =  type.getSelf(json) as! M
                return IaskuResult.Success(obj)
                break
            case  Failure(let errorType):
                return IaskuResult.Failure(errorType)
                break
                
            }
           
            
            })
    }
}
*/

