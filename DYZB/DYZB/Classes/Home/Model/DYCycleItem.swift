//
//  DYCycleItem.swift
//  DYZB
//
//  Created by ma c on 16/10/30.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYCycleItem: NSObject {
    
    /// 标题
    var title = ""
    /// 展示的图片地址
    var pic_url = ""
    /// 主播信息对应的字典
    var room : [String : Any]? {
        didSet {
            guard let room = room else {
                return
            }
            
            anchor = DYAnchorItem(dict: room)
        }
    }
    
    /// 主播信息对应的模型
    var anchor : DYAnchorItem?
    
    
    
    // MARK: - 自定义构造函数
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
