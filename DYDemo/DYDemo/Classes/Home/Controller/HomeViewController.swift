//
//  HomeViewController.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/5.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    //  MARK: 懒加载属性
    lazy var pageTitleView : PageTitleView = {
        
        let titleFrame = CGRect.init(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView.init(frame: titleFrame, titles: titles)
        
        return titleView
    }()
    
    lazy var pageContentView : PageContentView = {
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect.init(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        var childVCs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController.init()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        
        let contentView = PageContentView.init(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpUI()
    }

    

}

// MARK:设置UI界面
extension HomeViewController {
    
    func setUpUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        //  设置导航栏
        setUpNavigationBar()
        
        //  添加TitleView
        self.view.addSubview(pageTitleView)
        
        //  添加ContentView
        self.view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    
    func setUpNavigationBar() {
        
        //  设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo")
        
        //  设置右侧item
        let size = CGSize.init(width: 35, height: 35)
        //  1.历史
        let historyItem = UIBarButtonItem.init(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        //  2.搜索
        let searchItem = UIBarButtonItem.init(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        //  3.二维码
        let qrcodeItem = UIBarButtonItem.init(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
    
    
}
