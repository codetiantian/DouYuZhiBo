//
//  UIBarButton-Extention.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/7.
//  Copyright © 2017年 YLT. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    class func createItem(imageName:String, highImageName:String, size:CGSize) ->UIBarButtonItem {
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        btn.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        
        return UIBarButtonItem.init(customView: btn)
    }
}
