//
//  DYFunnyViewController.swift
//  DYZB
//
//  Created by 师飞 on 2017/3/1.
//  Copyright © 2017年 shifei. All rights reserved.
//

import UIKit
private let kTopMargain : CGFloat = 8

class DYFunnyViewController: DYBaseViewController {
    // 懒加载viewmodel对象
    fileprivate lazy var funnyVM : DYFunnyViewModel = DYFunnyViewModel()
    
}

extension DYFunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collection.contentInset = UIEdgeInsets(top: kTopMargain, left: 0, bottom: 0, right: 0)
        
    }
}

extension DYFunnyViewController {
    override func loadData() {
        // 1.给父类中的viewmodel赋值
        baseVM = funnyVM
        
        // 2.请求数据
        funnyVM.loadFunnyData {
            self.collection.reloadData()
        }
    }
}
