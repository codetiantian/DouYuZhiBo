//
//  PageContentView.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/9.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"


class PageContentView: UIView {
    
    //  定义属性
    var childVCs : [UIViewController] = [UIViewController]()
    var parentViewController : UIViewController
    
    // MARK:懒加载属性
    lazy var collectionView : UICollectionView = {
        //  1.创建layout
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        //  2.创建collectionView
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    //  MARK:自定义构造函数
    init(frame: CGRect, childVCs : [UIViewController], parentViewController : UIViewController) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//  MARK:设置UI界面
extension PageContentView {
    func setupUI() {
        //  1.将所有子控制器添加到父控制器中
        for childVC in self.childVCs {
            self.parentViewController.addChildViewController(childVC)
        }
        
        //  2.添加UICollectionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//  MARK:遵守UICollectionView协议
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //  1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2.给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
}
