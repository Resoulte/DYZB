//
//  DYAnchorItem.swift
//  DYZB
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYAnchorItem: NSObject {
    /// 房间ID
    var room_id = 0
    /// 房间图片对应的urlstring
    var vertical_src = ""
    /// 判断是手机直播还是电视直播
    // 0：电脑 1：手机
    var isVertical = 0
    /// 房间名称
    var room_name = ""
    /// 主播昵称
    var nickname = ""
    /// 观看人数
    var online = 0
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    
}
