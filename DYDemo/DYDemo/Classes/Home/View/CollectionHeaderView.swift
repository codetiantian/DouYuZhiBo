//
//  CollectionHeaderView.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/14.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    //  MARK:- 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //  MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage.init(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
