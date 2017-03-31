//
//  AnchorGroup.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/17.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet{     //  需要查看了解
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel.init(dic: dict))
            }
        }
    }
    
    /// 组显示的标题
    var tag_name : String = ""
    
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    
    /// 游戏对应的图标
    var icon_url : String = ""
    
    
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    //  MARK:- 构造函数
    override init() {
    }
    
    //  MARK:- 重载
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
