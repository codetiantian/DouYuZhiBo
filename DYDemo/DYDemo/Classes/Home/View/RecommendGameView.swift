//
//  RecommendGameView.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/30.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class RecommendGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        //  让控件不随着父控件拉伸而拉伸
        autoresizingMask = .init()
        
        //  注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
        
        //  设置约束
        
    }

}

extension RecommendGameView {
    //  MARK:- 提供快速创建类方法
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)!.first as! RecommendGameView
    }
}

//  MARK:- 遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        
        return cell
    }
}
