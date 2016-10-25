//
//  DYPageContentView.swift
//  DYZB
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView: DYPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let contentCellID = "contentCellID"

class DYPageContentView: UIView {
    
    // MARK:- 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentViewController : UIViewController?
    fileprivate var startoffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    // MARK: - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建流式布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
    }()

   // MARK: -自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: -设置UI界面
extension DYPageContentView {
    
    fileprivate func setupUI() {
        // 1.将所有子控制器添加到父控制器
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        // 2.添加UICollectionView,用于在cell中存放控制的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension DYPageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVcs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

// MARK: -遵守UICollectionViewDelegate
extension DYPageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        startoffsetX = scrollView.contentOffset.x
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0.判断是否点击事件
        if isForbidScrollDelegate { return }
        
        // 1.定义需要获得数据
        var progress : CGFloat = 0
        var sourceIndex = 0
        var targetIndex = 0
        
        // 2.判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startoffsetX { // 左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex 
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 4.如果完全滑过去
            if currentOffsetX - startoffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { // 右滑
            
            // 1.计算progress
            progress = 1 - (currentOffsetX / startoffsetX - floor(currentOffsetX / startoffsetX))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / startoffsetX)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count  {
                sourceIndex = childVcs.count - 1
            }
            
        }
        
        // 3.将progress/sourceIndex/targetIndex传给titileView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        
        
        
    }
}

// MARK: -对外暴露的方法
extension DYPageContentView {
    func setCurrentIndex(_ currentIndex: Int) {
        
        // 1.记录需要执行代理方法
        isForbidScrollDelegate = true
        
        // 2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
