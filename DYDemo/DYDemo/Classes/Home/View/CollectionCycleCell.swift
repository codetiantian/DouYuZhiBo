//
//  CollectionCycleCell.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/28.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            
            let iconURL = URL.init(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL)
        }
    }

}
