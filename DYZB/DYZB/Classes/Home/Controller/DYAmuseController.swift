//
//  DYAmuseController.swift
//  DYZB
//
//  Created by ma c on 16/11/5.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYAmuseController: DYBaseViewController {

    // MARK: - 懒加载
    lazy var amuseVM = DYAmuseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//  MARK: - 加载数据
extension DYAmuseController {
   override func loadData() {
    // 1.给父类中的viewModel赋值
        baseVM = amuseVM
    // 2.请求数据
        amuseVM.loadAmuseData {
            self.collection.reloadData()
        }
    }
}

