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
    func loadAnchorsData(URLString : String, params : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        DYNetWorksTools.requestJsonData(type: .get, URLString: URLString, params: params) { (json) in
            // 1.获取数据
            guard let jsonArray = json as? [String : Any] else { return }
            guard let dataArray = jsonArray["data"] as? [[String : Any]] else { return }
            
            // 2.遍历数组转模型
            for dict in dataArray {
                self.anchorGroups.append(DYAnchorGroupItem(dict: dict))
            }
            
            // 3.回调
            finishedCallback()
            
        }

    }
}
