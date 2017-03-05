//
//  MainViewController.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/5.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addChildVC(storyName:String) {
        let childVC = UIStoryboard.init(name:storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
    }

}
