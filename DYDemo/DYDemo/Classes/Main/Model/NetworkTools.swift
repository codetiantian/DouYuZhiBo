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
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type : MethodType, url : String, parameters : [String : String]? = nil, finishedCallback : (_ result : AnyObject) -> ()) {
        
        //  1.获取类型
        let method = type == MethodType.GET ? MethodType.GET : MethodType.POST
        
        
        
    }
}
