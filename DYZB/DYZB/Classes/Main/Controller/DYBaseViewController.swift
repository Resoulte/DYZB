//
//  DYBaseViewController.swift
//  DYZB
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

// MARK: -定义常量
private let kMargain : CGFloat = 10


private let kHeaderH : CGFloat = 50
private let kGameViewH : CGFloat = 90.0

private let kHeaderID = "headerID"

let kNormalID = "normalID"
let kPrettyID = "prettyID"
let kNormalItemW = (kScreenW - kMargain * 3) / 2
let kNormalItemH = kNormalItemW * 3/4
let kPrettyItemH = kNormalItemW * 4/3



class DYBaseViewController: UIViewController {

    // MARK: - 定义属性
    var baseVM : DYBaseViewModel!
    lazy var collection: UICollectionView = { [weak self] in
        
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = kMargain
        flow.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        // 设置内边距
        flow.sectionInset = UIEdgeInsets(top: 0, left: kMargain, bottom: 0, right: kMargain)
        
        
        let collection = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: flow)
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
//        collection.delegate = self
        
        // MARK: - 根据父控件的宽高自动调整
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collection.register(UINib(nibName: "DYNormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalID)
        
        collection.register(UINib(nibName: "DYPrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyID)
        
        collection.register(UINib(nibName: "DYHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        
        return collection
        }()
    
    // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI
        setupUI()
        
        // 加载数据
        loadData()
    }

}

//  MARK: - 加载数据
extension DYBaseViewController {
    func loadData() {
                
    }
}

// MARK: - 设置UI布局
extension DYBaseViewController {
    func setupUI() {
        // 添加collection
        view.addSubview(collection)
    }
}


// MARK: - UICollectionViewDataSource
extension DYBaseViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalID, for: indexPath) as! DYNormalCollectionViewCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        //        cell.backgroundColor = UIColor.randomColor()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! DYHeaderCollectionReusableView
        header.group = baseVM.anchorGroups[indexPath.section]
        
        return header
    }
}

