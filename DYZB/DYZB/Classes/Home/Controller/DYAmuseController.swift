//
//  DYAmuseController.swift
//  DYZB
//
//  Created by ma c on 16/11/5.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

private let kAmuseMenuViewH : CGFloat = 200

class DYAmuseController: DYBaseViewController {

    // MARK: - 懒加载
    lazy var amuseVM = DYAmuseViewModel()
    lazy var amuseMenuView: DYAmuseMenuView = {
        let amuseMenuView = DYAmuseMenuView.amuseMenuView()
        amuseMenuView.frame = CGRect(x: 0, y: -kAmuseMenuViewH, width: kScreenW, height: kAmuseMenuViewH)
        amuseMenuView.backgroundColor = UIColor.purple
        return amuseMenuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DYAmuseController {
    override func setupUI() {
        super.setupUI()
        // 将菜单的view加到collection
        collection.addSubview(amuseMenuView)
        collection.contentInset = UIEdgeInsets(top: kAmuseMenuViewH, left: 0, bottom: 0, right: 0)
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

