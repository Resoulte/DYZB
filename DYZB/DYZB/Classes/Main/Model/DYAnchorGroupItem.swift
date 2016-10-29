//
//  DYAnchorGroupItem.swift
//  DYZB
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYAnchorGroupItem: NSObject {
    /// 改组中对应的房间信息
    var room_list : [[String : Any]]? {
       // 属性监听器
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(DYAnchorItem(dict: dict))
            }
        }
    }
    /// 组显示的标题
    var tag_name = ""
    /// 组显示的图标
    var icon_name = "home_header_normal"
    
    /// 定义主播的模型对象数组
    lazy var anchors = [DYAnchorItem]()
    
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    // 方法1
    /*
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : Any]] {
                for dict in dataArray {
                    anchors.append(DYAnchorItem(dict: dict))
                }
            }
            
        }
    }
 */
    
    
}
