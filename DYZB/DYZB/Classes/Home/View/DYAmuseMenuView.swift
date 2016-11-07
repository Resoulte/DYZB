//
//  DYAmuseMenuView.swift
//  DYZB
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

private let kAmuseViewID = "kAmuseViewID"

class DYAmuseMenuView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    // MARK: - 从xib中加载
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "DYAmuseCollectionCell", bundle: nil), forCellWithReuseIdentifier: kAmuseViewID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
    }
}

// MARK: - 快速创建方法
extension DYAmuseMenuView {
    class func amuseMenuView() -> DYAmuseMenuView {
        return Bundle.main.loadNibNamed("DYAmuseMenuView", owner: nil, options: nil)?.first as! DYAmuseMenuView
    }
}

extension DYAmuseMenuView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseViewID, for: indexPath)
//        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}
