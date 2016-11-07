//
//  DYAmuseMenuView.swift
//  DYZB
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYAmuseMenuView: UIView {

   
}

// MARK: - 快速创建方法
extension DYAmuseMenuView {
    class func amuseMenuView() -> DYAmuseMenuView {
        return Bundle.main.loadNibNamed("DYAmuseMenuView", owner: nil, options: nil)?.first as! DYAmuseMenuView
    }
}
