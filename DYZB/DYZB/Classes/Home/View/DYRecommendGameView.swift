//
//  DYRecommendGameView.swift
//  DYZB
//
//  Created by ma c on 16/10/30.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInset : CGFloat = 10

class DYRecommendGameView: UIView {

    // MARK: - 定义数据属性
    var groups : [DYAnchorGroupItem]? {
        didSet {
            
            // 1.移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            // 添加更多
            let moreGroup = DYAnchorGroupItem()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            
            // 2.刷新表格
            CollectionView.reloadData()
            
        }
        
        
    }
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        // 注册cell
        CollectionView.register( UINib(nibName: "DYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        let layout =  CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 90)
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInset, bottom: 0, right: kEdgeInset)
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
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as!DYCollectionGameCell
        cell.baseItem = groups?[indexPath.item]
        
        
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        return cell
    }
}
