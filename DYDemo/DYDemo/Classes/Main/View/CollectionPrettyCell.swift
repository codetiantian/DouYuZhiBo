//
//  CollectionPrettyCell.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/14.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    //  MARK:-  定义模型属性
    override var anchor : AnchorModel? {
        didSet{
            super.anchor = anchor
            
            //  显示城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
    
}
