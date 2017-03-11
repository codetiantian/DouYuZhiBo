//
//  PageContentView.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/9.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, prog : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    //  定义属性
    var childVCs : [UIViewController] = [UIViewController]()
    weak var parentViewController : UIViewController?
    var startOffsetX : CGFloat = 0
    var isForbidScrollDelegate : Bool = false
    
    weak var delegate : PageContentViewDelegate?
    
    // MARK:懒加载属性
    lazy var collectionView : UICollectionView = { [weak self] in
        //  1.创建layout
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        //  2.创建collectionView
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    //  MARK:自定义构造函数
    init(frame: CGRect, childVCs : [UIViewController], parentViewController : UIViewController?) {
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
            parentViewController?.addChildViewController(childVC)
        }
        
        //  2.添加UICollectionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//  MARK:遵守UICollectionViewDataSource协议
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

//  MARK: -遵守UICollectionViewDelegate协议
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //  判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        
        //  1.获取需要的数据
        var prog : CGFloat = 0
        var sourcrIndex : Int = 0
        var tagetIndex : Int = 0
        
        //  判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX {      //  左滑
            //  1.计算progress
            prog = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            //  2.计算sourcrIndex
            sourcrIndex = Int(currentOffsetX / scrollViewW)
            
            //  3.计算tagetIndex
            tagetIndex = sourcrIndex + 1
            if tagetIndex >= childVCs.count {
                tagetIndex = childVCs.count - 1
            }
            
            //  4.完全滑过去
            if  currentOffsetX - startOffsetX == scrollViewW {
                prog = 1
                tagetIndex = sourcrIndex
            }
            
        } else {        //  右滑
            //  1.计算progress
            prog = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //  2.计算tagetIndex
            tagetIndex = Int(currentOffsetX / scrollViewW)
            
            //  3.计算sourcrIndex
            sourcrIndex = tagetIndex + 1
            
            if sourcrIndex >= childVCs.count {
                sourcrIndex = childVCs.count - 1
            }
        }
        
        //  传递prog、sourcrIndex、tagetIndex
        delegate?.pageContentView(contentView: self, prog: prog, sourceIndex: sourcrIndex, targetIndex: tagetIndex)
    }
}

//  MARK: 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        //  1.记录需要禁止执行代理方法
        isForbidScrollDelegate = true
        
        //  2.滚到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.contentOffset = CGPoint.init(x: offsetX, y: 0)
    }
}
