//
//  CollectionBaseCell.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/22.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    //  定义模型
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            
            //  在线人数
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            
            onlineButton.setTitle(onlineStr, for: .normal)
            
            //  显示昵称
            nickNameLabel.text = anchor.nickname
            
            //  显示封面图片
            guard let iconURL = URL.init(string: anchor.vertical_src) else {
                return
            }
            
            iconImageView.kf.setImage(with: iconURL)
        }
    }
    
}
