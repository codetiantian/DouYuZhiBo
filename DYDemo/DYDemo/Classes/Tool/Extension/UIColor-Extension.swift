//
//  UIColor-Extension.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/9.
//  Copyright © 2017年 YLT. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
     convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
