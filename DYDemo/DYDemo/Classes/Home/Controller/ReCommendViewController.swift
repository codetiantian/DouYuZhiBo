//
//  ReCommendViewController.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/13.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kNormalHeaderViewID = "kNormalHeaderViewID"

class ReCommendViewController: UIViewController {

    //  MARK:- 懒加载属性
    lazy var collectionView : UICollectionView = { [unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize.init(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //  注册cell
        collectionView.register(UINib.init(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib.init(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        //  注册header
        collectionView.register(UINib.init(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kNormalHeaderViewID)
        
        return collectionView
    }()
    
    //  MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.purple
        
        setupUI()
    }

}

//  MARK:- 设置UI界面内容
extension ReCommendViewController {
    func setupUI() {
        view.addSubview(collectionView)
    }
}

//  MARK:- 遵守UIColectionView DataSource协议
extension ReCommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //  1.定义cell
        var cell : UICollectionViewCell!
        
        //  2.取出cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //  1.取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeaderViewID, for: indexPath)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return  CGSize.init(width: kItemW, height: kPrettyItemH)
        } else {
            return  CGSize.init(width: kItemW, height: kNormalItemH)
        }
    }
    
}
