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
    
    // MARK: - 定义属性
    var cycleTimer : Timer?
    
    var cycleItems : [DYCycleItem]? {
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
            // 2.设置pageControl的个数
            pageControl.numberOfPages = cycleItems?.count ?? 0
            // 3.默认滚动到中间的某个位置
            let index = NSIndexPath(item: (cycleItems?.count ?? 0)! * 100, section: 0)
            collectionView.scrollToItem(at: index as IndexPath, at: .left, animated: false)
            
            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
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
        return (cycleItems?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCell, for: indexPath) as! DYCollectionCycleCell
        cell.cycleItem = cycleItems?[indexPath.item % (cycleItems?.count)!]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DYRecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取滚动的偏移量
        let contenoffsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 计算pageControl的currentPage
        pageControl.currentPage = Int(contenoffsetX / scrollView.bounds.width) % (cycleItems?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

extension DYRecommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(self.scrollNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        // 从运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    func scrollNext() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x:offsetX, y:0), animated: true)
        
        
    }
    
}
