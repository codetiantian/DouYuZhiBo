//
//  RecommendCycleView.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/23.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

class RecommendCycleView: UIView {
    override func awakeFromNib() {
        //  设置该控件不随父控件拉伸
        autoresizingMask = UIViewAutoresizing()
    }
}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}
