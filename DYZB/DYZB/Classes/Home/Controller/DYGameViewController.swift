//
//  DYGameViewController.swift
//  DYZB
//
//  Created by ma c on 16/10/31.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

private let kMargain : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kMargain) / 3
private let kItemH = kItemW * 6 / 5
private let kHeaderH : CGFloat = 50
private let kHeaderView : CGFloat = 90
private let kGameCell = "kGameCell"
private let kGameHeader = "kGameHeader"

class DYGameViewController: DYAllBaseViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var gameVM = DYGameViewModel()
    fileprivate lazy var collection: UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargain, bottom: 0, right: kMargain)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        let collection = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.dataSource = self
        collection.register(UINib(nibName: "DYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCell)
        collection.register(UINib(nibName: "DYHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeader)
        
        return collection
    }()
    
    fileprivate lazy var topHeaderView: DYHeaderCollectionReusableView = {
        let  topHeaderView = DYHeaderCollectionReusableView.loadHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -(kHeaderH + kHeaderView), width: kScreenW, height: kHeaderH)
        topHeaderView.icon_name.image = UIImage(named: "Img_orange")
        topHeaderView.tag_name.text = "常见"
        topHeaderView.headerBtn.isHidden = true
        
        return topHeaderView
        
    }()
    
    fileprivate lazy var commonGameView : DYRecommendGameView = {
        let commonGameView = DYRecommendGameView.recommendGameView()
        commonGameView.frame = CGRect(x: 0, y: -kHeaderView, width: kScreenW, height: kHeaderView)
        
        return commonGameView
    }()
    
    // MARK: - 系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI
        setupUI()
       // 加载数据
        loadData()
        
    }

}

// MARK: - 设置UI
extension DYGameViewController {
    
    override func setupUI() {
        
        contentionView = collection
        
        // 1.添加collection
        view.addSubview(collection)
        // 2.往collectionview上添加topHeaderView
        collection.addSubview(topHeaderView)
        // 3.在collection上添加commonGameView
        collection.addSubview(commonGameView)
        
        // 设置collection的内边距
        collection.contentInset = UIEdgeInsets(top: kHeaderH + kHeaderView, left: 0, bottom: 0, right: 0)
        
        super.setupUI()
    }
}

// MARK: - 请求数据
extension DYGameViewController {
    func loadData() {
        gameVM.requestGameData {
            // 1.请求全部数据
            self.collection.reloadData()
            // 2.请求常见数据(ArraySlice)
            self.commonGameView.groups = Array(self.gameVM.gameItems[0..<10])
            
        }
        
        self.loadFinishedData()
    }
}

// MARK: - UICollectionViewDataSource
extension DYGameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: kGameCell, for: indexPath) as! DYCollectionGameCell
        
        cell.baseItem = gameVM.gameItems[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGameHeader, for: indexPath) as! DYHeaderCollectionReusableView
        header.tag_name.text = "全部"
        header.icon_name.image = UIImage(named: "Img_orange")
        header.headerBtn.isHidden = true
        
        return header
    }
}
