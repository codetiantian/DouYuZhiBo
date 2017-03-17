//
//  NSDate-Extension.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/17.
//  Copyright © 2017年 YLT. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let inteval = Int(nowDate.timeIntervalSince1970)
        
        return "\(inteval)"
    }
}
