//
//  DYRecommendController.swift
//  DYZB
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

// MARK: -定义常量
private let kMargain : CGFloat = 10
private let kItemW = (kScreenW - kMargain * 3) / 2
private let kItemH = kItemW * 3/4
private let kHeaderH : CGFloat = 50

private let kNormalID = "normalID"
private let kHeaderID = "headerID"


class DYRecommendController: UIViewController {

    // MARK: -懒加载
    lazy var collection: UICollectionView = { [weak self] in
        
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: kItemW, height: kItemH)
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = kMargain
        flow.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        
        let collection = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: flow)
        collection.backgroundColor = UIColor.blue
        collection.dataSource = self
        
        // MARK: - 根据父控件的宽高自动调整
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalID)
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        
        return collection
    }()
    
    // MARK: -系统回调的方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
       
        
        setupUI()
        
    }

}

// MARK: -设置UI界面
extension DYRecommendController {
    
   fileprivate func setupUI() {
        // 1.将UICollectionView加入控制器view当中
        view.addSubview(collection)
    }
}

extension DYRecommendController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 12
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else {
            return 4
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalID, for: indexPath)
        
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath)
        
        headerView.backgroundColor = UIColor.brown
        
        return headerView
    }
}
