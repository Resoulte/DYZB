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

    
    var groups : [DYAnchorGroupItem]? {
        didSet {
            collectionView.reloadData()
        }
    }
   
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
        if groups == nil {
            return 0
        }
//        let pageNum = (groups?.count)! % 8 + 1
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControll.numberOfPages = pageNum
        
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseViewID, for: indexPath) as! DYAmuseCollectionCell
//        cell.backgroundColor = UIColor.randomColor()
        // 给cell设置数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellDataWithCell(cell: DYAmuseCollectionCell, indexPath: IndexPath) {
        
        // o页：0-7
        // 1页：8-15
        // 2页：16-23
        // 取出起始位置,终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        // 判断越界问题
        if endIndex > (groups?.count)! - 1 {
            endIndex = (groups?.count)! - 1
        }
        
        // 取出数据并赋值给cell
        
        cell.groups = Array(groups![startIndex...endIndex])
        
        
        
    }
}

extension DYAmuseMenuView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControll.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
