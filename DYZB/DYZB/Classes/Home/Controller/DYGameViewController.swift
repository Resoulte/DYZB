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
private let kGameCell = "kGameCell"

class DYGameViewController: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var gameVM = DYGameViewModel()
    fileprivate lazy var collection: UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargain, bottom: 0, right: kMargain)
        
        let collection = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.dataSource = self
        collection.register(UINib(nibName: "DYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCell)
        
        return collection
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
    
    fileprivate func setupUI() {
        view.addSubview(collection)
    }
}

// MARK: - 请求数据
extension DYGameViewController {
    func loadData() {
        gameVM.requestGameData { 
            self.collection.reloadData()
        }
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
}
