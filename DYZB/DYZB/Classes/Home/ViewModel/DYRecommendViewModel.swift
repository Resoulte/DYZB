//
//  DYRecommendViewModel.swift
//  DYZB
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 shifei. All rights reserved.
//

/*
1.请求数据，遍历字典并且转成模型
2.对数据进行排序
3.显示headerview的内容
 */

import UIKit

class DYRecommendViewModel {
    // MARK: - 懒加载属性
     lazy var anchorGroups : [DYAnchorGroupItem] = [DYAnchorGroupItem]()
    fileprivate lazy var bigDataGroup = DYAnchorGroupItem()
    fileprivate lazy var prettyGroup = DYAnchorGroupItem()
    lazy var cycleItems = [DYCycleItem]()
}

// MARK: - 发送网络请求
extension DYRecommendViewModel {
    
    // 请求推荐数据
    func requestData(finishedCallBack: @escaping () -> ())   {
        
        // 1.请求热门数据
        let Group = DispatchGroup()
        
        Group.enter()
        DYNetWorksTools.requestJsonData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", params: ["time" : Date.getCurrentTime()]) { (json) in
            // 1.将json转换为字典
            guard let jsonDict = json as? [String : Any] else { return }
            // 2.根据data该key获取数组
            guard let dataArray = jsonDict["data"] as? [[String : Any]] else { return }
            // 3.遍历字典并且转成模型
            // 3.1 创建组
//            let group = DYAnchorGroupItem()
            // 3.2 设置组的属性
            self.bigDataGroup.icon_name = "home_header_hot"
            self.bigDataGroup.tag_name = "热门"
            // 3.3 获取主播数据
            for dict in dataArray {
                let anchor = DYAnchorItem(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            Group.leave()
            
        }
        
       // 2.请求颜值数据
        Group.enter()
        DYNetWorksTools.requestJsonData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: ["limit": 4, "offset" : 0, "time" : Date.getCurrentTime()]) { (json) in
            // 1.将json转换为字典
            guard let jsonDict = json as? [String : Any] else { return }
            
            // 2.根据data该key获取数组
            guard let dataArray = jsonDict["data"] as? [[String : Any]] else { return }
            
            // 3.遍历字典并且转成模型对象
            // 3.1 创建组
//            let group = DYAnchorGroupItem()
            // 3.2 设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            // 3.3 获取主播数据
            for dict in dataArray {
                let anchor = DYAnchorItem(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            Group.leave()
        }
        
        // 3.请求游戏数据
        Group.enter()
        DYNetWorksTools.requestJsonData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", params: ["limit" : 4, "offset" : 0, "time" : Date.getCurrentTime()]) { (json) in
            
            // 1.将json转换为字典
            guard let jsonDict = json as? [String : Any] else { return }
            
            // 2.根据data该key获取数组(数组里面又放的是字典)
            guard let dataArray = jsonDict["data"] as? [[String : Any]] else { return }
            
            // 3.遍历字典，并且转成模型对象
            for dictItem in dataArray {
                let group = DYAnchorGroupItem(dict: dictItem)
                self.anchorGroups.append(group)
            }
            
//            for group in self.anchorGroups {
//                for anchor in group.anchors {
////                    print(anchor.nickname)
//                }
////                print("-----")
//            }
            Group.leave()
            
            
            
        }
        
        // 所有的数据都请求到,之后进行排序
        Group.notify(queue: .main) {
//            print("所有的数据都请求到")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
          
            
            finishedCallBack()
        }
        
        
    }
    
    // 请求无限轮播数据
    func requestCycleData(finishedBack: @escaping () -> ()) {
        DYNetWorksTools.requestJsonData(type: .get, URLString: "http://www.douyutv.com/api/v1/slide/6", params: ["version" : 2.300]) { (json) in
            
//            print(json)
            // 1.获取字典数据
            guard let jsonDict = json as? [String : Any] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = jsonDict["data"] as? [[String: Any]] else { return }
            
            print(dataArray)
            // 3.字典转模型
            for dict in dataArray {
                self.cycleItems.append(DYCycleItem(dict: dict))
            }
            finishedBack()
            
        }
    }
}

