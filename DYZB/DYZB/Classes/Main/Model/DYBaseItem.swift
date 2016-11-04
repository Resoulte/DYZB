//
//  DYBaseItem.swift
//  DYZB
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYBaseItem: NSObject {
    // MARK: - 定义属性
    /// 组显示的标题
    var tag_name = ""
    /// 游戏对应的图标
    var icon_url = ""
    
    override init() {
        
    }
    
    // MARK: - 自定义构造函数
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }

}
