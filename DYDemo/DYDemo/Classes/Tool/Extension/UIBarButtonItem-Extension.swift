//
//  UIBarButtonItem-Extension.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/8.
//  Copyright © 2017年 YLT. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    //  类方法
//    class func createItem(imageName:String, highImageName:String, size:CGSize) ->UIBarButtonItem {
//        let btn = UIButton.init()
//        btn.setImage(UIImage.init(named: imageName), for: .normal)
//        btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
//        btn.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
//        
//        return UIBarButtonItem.init(customView: btn)
//    }
    
    // 便利构造函数
    convenience init(imageName:String, highImageName:String = "", size:CGSize = CGSize.init(width: 0, height: 0)) {
        
        //  创建btn
        let btn = UIButton.init()
        
        //  设置btn的图片
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        }
        
        //  设置btn尺寸
        if size != CGSize.init(width: 0, height: 0) {
            btn.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        } else {
            btn.sizeToFit()
        }
        
        //  创建UIBarButtonItem
        self.init(customView:btn)
    }
    
}
