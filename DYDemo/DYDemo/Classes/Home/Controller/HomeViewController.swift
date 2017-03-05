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
        let historyBtn = UIButton.init()
        historyBtn.setImage(UIImage.init(named: "image_my_history"), for: .normal)
        historyBtn.setImage(UIImage.init(named: "Image_my_history_click"), for: .highlighted)
        historyBtn.sizeToFit()
        let historyItem = UIBarButtonItem.init(customView: historyBtn)
        
        
        let searchBtn = UIButton.init()
        searchBtn.setImage(UIImage.init(named: "btn_search"), for: .normal)
        searchBtn.setImage(UIImage.init(named: "btn_search_clicked"), for: .highlighted)
        searchBtn.sizeToFit()
        let searchItem = UIBarButtonItem.init(customView: searchBtn)
        
        let QRCodeBtn = UIButton.init()
        QRCodeBtn.setImage(UIImage.init(named: "Image_scan"), for: .normal)
        QRCodeBtn.setImage(UIImage.init(named: "Image_scan_click"), for: .highlighted)
        QRCodeBtn.sizeToFit()
        let QRCodeItem = UIBarButtonItem.init(customView: QRCodeBtn)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, QRCodeItem]
    }
    
    
}
