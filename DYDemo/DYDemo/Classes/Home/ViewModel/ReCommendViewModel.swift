//
//  ReCommendViewModel.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/17.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

class ReCommendViewModel {
    //  MARK:- 懒加载属性
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    lazy var prettyGroup : AnchorGroup = AnchorGroup()
}


//  MARK:- 发送网络请求
extension ReCommendViewModel {
    //  请求推荐数据
    func requestrData(finishCallback : @escaping () -> ()) {
        //  1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        //  2.创建Group
        let disGroup = DispatchGroup()
        
        
        //  3、请求第一部分推荐数据
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1489730081
        
        disGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            //  1.将result转成字典
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            //  2.根据data该key，获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            //  3.遍历数组，获取字典，并且将字典转成模型对象
            //  3.1设置组属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //  3.2获取主播信息
            for dict in dataArray {
                let anchor = AnchorModel.init(dic: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            //  3.3离开组
            disGroup.leave()
        }
        
        //  4、请求第二部分颜值数据
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1489730081
        
        disGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //  1.将result转成字典
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            //  2.根据data该key，获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            //  3.遍历数组，获取字典，并且将字典转成模型对象
            //  3.1设置组属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            //  3.2获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel.init(dic: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            //  3.3离开组
            disGroup.leave()
        }
        
        //  5、请求后面部分的游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1489730081
        
        disGroup.enter()
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            //  1.将result转成字典
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            
            //  2.根据data该key，获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            
            //  3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup.init(dict: dict)
                self.anchorGroups.append(group)
            }
            
            //  4离开组
            disGroup.leave()
        }
        
        //  6.所有的数据都请求到，进行排序
        disGroup.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
    
    //  请求无限轮播数据
    func requestCycleData(finishCallback : @escaping () -> ()) {
        
        NetworkTools.requestData(type: .get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            guard let resultDic = result as? [String : NSObject] else {
                return
            }
            
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {
                return
            }
            
            //  字典转模型
            for dict in dataArray {
                self.cycleModels.append(CycleModel.init(dict: dict))
            }
            
            finishCallback()
        }
    }
}
