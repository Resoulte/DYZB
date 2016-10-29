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
private let kNormalItemH = kItemW * 3/4
private let kPrettyItemH = kItemW * 4/3
private let kHeaderH : CGFloat = 50

private let kNormalID = "normalID"
private let kPrettyID = "prettyID"
private let kHeaderID = "headerID"


class DYRecommendController: UIViewController {

    // MARK: -懒加载
    lazy var recommendVM = DYRecommendViewModel()
    lazy var collection: UICollectionView = { [weak self] in
        
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = kMargain
        flow.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        // 设置内边距
        flow.sectionInset = UIEdgeInsets(top: 0, left: kMargain, bottom: 0, right: kMargain)
        
        
        let collection = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: flow)
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        collection.delegate = self
        
        // MARK: - 根据父控件的宽高自动调整
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collection.register(UINib(nibName: "DYNormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalID)
        
         collection.register(UINib(nibName: "DYPrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kPrettyID)
        
        collection.register(UINib(nibName: "DYHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        
        return collection
    }()
    
    // MARK: -系统回调的方法
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        setupUI()
        
        // 发送网络请求
        loadData()
    }

}

// MARK: - 设置UI界面
extension DYRecommendController {
    
   fileprivate func setupUI() {
        // 1.将UICollectionView加入控制器view当中
        view.addSubview(collection)
    }
}

// MARK: - 请求数据
extension DYRecommendController {
    fileprivate func loadData() {
        recommendVM.requestData()
    }
    
}

extension DYRecommendController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        var cell = UICollectionViewCell()
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyID, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalID, for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath)
        
//        headerView.backgroundColor = UIColor.brown
               
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        } else {
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
}
