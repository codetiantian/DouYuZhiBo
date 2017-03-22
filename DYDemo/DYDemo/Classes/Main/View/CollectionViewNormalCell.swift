//
//  CollectionViewNormalCell.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/14.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
    //  MARK:-  定义模型属性
    override var anchor : AnchorModel? {
        didSet {
           super.anchor = anchor

            //  房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }

}
