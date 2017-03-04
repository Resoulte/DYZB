//
//  DYBaseViewModel.swift
//  DYZB
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYBaseViewModel {
    
    lazy var anchorGroups = [DYAnchorGroupItem]()
}

extension DYBaseViewModel {
    func loadAnchorsData(isGroupData : Bool, URLString : String, params : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        DYNetWorksTools.requestJsonData(type: .get, URLString: URLString, params: params) { (json) in
            // 1.获取数据
            guard let jsonArray = json as? [String : Any] else { return }
            guard let dataArray = jsonArray["data"] as? [[String : Any]] else { return }
            
            // 2.判断是否是分组数据
            if isGroupData {
                // 2.1遍历数组转模型
                for dict in dataArray {
                    self.anchorGroups.append(DYAnchorGroupItem(dict: dict))
                }

            } else {
                // 2.1创建组
                let group = DYAnchorGroupItem()
                
                // 2.2遍历dataArray中所有的字典
                for dict in dataArray {
                    group.anchors.append(DYAnchorItem(dict : dict))
                }
                // 2.3讲group添加到anchorGroup
                self.anchorGroups.append(group)
            }
            
            
            
            // 3.回调
            finishedCallback()
            
        }

    }
}
