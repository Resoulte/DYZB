//
//  DYRecommendCycleView.swift
//  DYZB
//
//  Created by ma c on 16/10/30.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

private let kCycleCell = "kCycleCell"

class DYRecommendCycleView: UIView {

    
    // MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleItems : [DYCycleItem]? {
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
            // 2.设置pageControl的个数
            pageControl.numberOfPages = cycleItems?.count ?? 0
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //  设置该控件 不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        // 注册cell
        collectionView.register(UINib(nibName: "DYCollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCell)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = collectionView.bounds.size
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
    }
}

extension DYRecommendCycleView {
    
    class func recommendCycleView() -> DYRecommendCycleView {
        return Bundle.main.loadNibNamed("DYRecommendCycleView", owner: nil, options: nil)?.first as! DYRecommendCycleView
    }
}

// MARK: - UICollectionViewDataSource
extension DYRecommendCycleView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCell, for: indexPath) as! DYCollectionCycleCell
        cell.cycleItem = cycleItems?[indexPath.item]
        
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DYRecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取滚动的偏移量
        let contenoffsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 计算pageControl的currentPage
        pageControl.currentPage = Int(contenoffsetX / scrollView.bounds.width)
    }
}
