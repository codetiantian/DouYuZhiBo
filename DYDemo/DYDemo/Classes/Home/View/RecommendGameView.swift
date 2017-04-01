//
//  RecommendGameView.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/30.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMagin : CGFloat = 10

class RecommendGameView: UIView {
    
    //  MARK: 定义数据的属性
    var groups : [AnchorGroup]? {
        didSet {
            //  刷新表格之前指出前两组数据
            groups?.remove(at: 0)
            groups?.remove(at: 0)
            
            //  添加更多组
            let moreGroup = AnchorGroup.init()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        //  让控件不随着父控件拉伸而拉伸
        autoresizingMask = .init()
        
        //  注册cell
        collectionView.register(UINib.init(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        //  添加内边距
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMagin, 0, kEdgeInsetMagin)
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
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        let group = groups![indexPath.item]
        cell.group = group
        
        return cell
    }
}
