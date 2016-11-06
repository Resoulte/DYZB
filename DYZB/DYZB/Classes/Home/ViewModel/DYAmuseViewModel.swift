//
//  DYAmuseViewModel.swift
//  DYZB
//
//  Created by ma c on 16/11/6.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYAmuseViewModel {
    lazy var anchorGroup = DYAnchorGroupItem()
    lazy var anchorGroups = [DYAnchorGroupItem]()
}

extension DYAmuseViewModel {
    func loadAmuseData(finishCalllBack: @escaping () -> ()) {
        DYNetWorksTools.requestJsonData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (json) in
            // 1.获取数据
            guard let jsonArray = json as? [String : Any] else { return }
            guard let dataArray = jsonArray["data"] as? [[String : Any]] else { return }
            
            // 2.遍历数组转模型
            for dict in dataArray {
                self.anchorGroups.append(DYAnchorGroupItem(dict: dict))
            }
            
            // 3.回调
            finishCalllBack()
            
        }
    }
}
