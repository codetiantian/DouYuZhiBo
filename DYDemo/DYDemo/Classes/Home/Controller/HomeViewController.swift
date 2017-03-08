//
//  HomeViewController.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/5.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpUI()
    }

    

}

// MARK:设置UI界面
extension HomeViewController {
    
    func setUpUI() {
        //  设置导航栏
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        
        //  设置左侧item
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: "logo"), for: .normal)
        btn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
        
        //  设置右侧item
        let size = CGSize.init(width: 35, height: 35)
        //  1.历史
        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        //  2.搜索
        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        //  3.二维码
        let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
    
    
}
