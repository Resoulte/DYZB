//
//  DYRecommendGameView.swift
//  DYZB
//
//  Created by ma c on 16/10/30.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class DYRecommendGameView: UIView {

    @IBOutlet weak var CollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        // 注册cell
//        UINib(nibName: "", bundle: nil)
        CollectionView.register(UICollectionViewCell
            .self, forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        let layout =  CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 90)
        CollectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - 提供快速创建的类方法
extension DYRecommendGameView {
    class func recommendGameView() -> DYRecommendGameView {
        return Bundle.main.loadNibNamed("DYRecommendGameView", owner: nil, options: nil)?.first as! DYRecommendGameView
    }
}

extension DYRecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        return cell
    }
}
