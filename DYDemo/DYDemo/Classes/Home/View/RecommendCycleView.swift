//
//  RecommendCycleView.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/23.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    //  定义属性
    var cycleModels : [CycleModel]? {
        didSet {
            //  刷新collectionView
            collectionView.reloadData()
            
            //  设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        //  设置该控件不随父控件拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //  注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //  设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
    }
}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//  MARK:- 遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath)
        
        let cycleModel = cycleModels![indexPath.item]
         
        
        
        return cell
    }
}
