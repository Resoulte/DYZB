//
//  DYRecommendViewModel.swift
//  DYZB
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYRecommendViewModel {
    // MARK: - 懒加载属性
    fileprivate lazy var anchorGroups : [DYAnchorGroupItem] = [DYAnchorGroupItem]()
    
}

// MARK: - 发送网络请求
extension DYRecommendViewModel {
    
    func requestData()  {
        
        // 1.请求热门数据
       
        DYNetWorksTools.requestJsonData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", params: ["time" : Date.getCurrentTime()]) { (json) in
            
        }
        
       // 2.请求颜值数据
        DYNetWorksTools.requestJsonData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: ["limit":"4", "offset" : "0", "time" : Date.getCurrentTime()]) { (json) in
            
        }
        
        // 3.请求游戏数据
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
            
            for group in self.anchorGroups {
                for anchor in group.anchors {
                    print(anchor.nickname)
                }
                print("-----")
            }
            
            
            
            
        }
        
    }
}

