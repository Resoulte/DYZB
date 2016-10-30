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
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90.0
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
    
     lazy var cycleView : DYRecommendCycleView = {
        
        let cycleView = DYRecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
        
    }()
    
    lazy var gameView : DYRecommendGameView = {
        let gameView = DYRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
    }()
    // MARK: -系统回调的方法
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        setupUI()
        
        // 发送网络请求
        loadData()
        
        loadCycleData()
    }

}

// MARK: - 设置UI界面
extension DYRecommendController {
    
   fileprivate func setupUI() {
        // 1.将UICollectionView加入控制器view当中
        view.addSubview(collection)
    
        // 2.将cycleView加到collectionview
        collection.addSubview(cycleView)
    
        // 将gameView加到collectionview
        collection.addSubview(gameView)
    
        // 3.设置collectionview的内边距
        collection.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 请求数据
extension DYRecommendController {
    // 请求推荐数据
    fileprivate func loadData() {
        recommendVM.requestData {
            self.collection.reloadData()
            
            // 将数据传给gameView
            self.gameView.groups = self.recommendVM.anchorGroups
        }
    }
    
    // 请求轮播数据
    fileprivate func loadCycleData() {
        recommendVM.requestCycleData {
            self.cycleView.cycleItems = self.recommendVM.cycleItems
        }
    }
    
}

extension DYRecommendController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return recommendVM.anchorGroups.count
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyID, for: indexPath) as! DYPrettyCollectionViewCell
            cell.anchor = anchor
            return cell
        } else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalID, for: indexPath) as! DYNormalCollectionViewCell
            cell.anchor = anchor
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! DYHeaderCollectionReusableView
        
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        

               
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
