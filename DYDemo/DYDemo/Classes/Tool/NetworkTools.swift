//
//  NetworkTools.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/15.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping (_ result : Any) -> ()) {
        
        //  1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //  2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            //  3.获取结果
            //  ?? 空合运算符
            guard let result = response.result.value else {
                print(response.result.error ?? "服务器返回数据错误")
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
}
