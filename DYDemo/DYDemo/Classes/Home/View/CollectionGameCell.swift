//
//  CollectionGameCell.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/31.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //  MARK: 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            let iconUrl = URL.init(string: group?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage.init(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
