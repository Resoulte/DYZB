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
    
}

extension DYFunnyViewController {
    override func setupUI() {
        super.setupUI()
        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collection.contentInset = UIEdgeInsets(top: kTopMargain, left: 0, bottom: 0, right: 0)
        
    }
}
