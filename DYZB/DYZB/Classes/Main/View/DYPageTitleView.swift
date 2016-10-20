//
//  DYPageTitleView.swift
//  DYZB
//
//  Created by ma c on 16/10/20.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

// MARK: - 定义常量
private let kScrollLineH : CGFloat = 2

// MARK: - 定义PageTitleView类
class DYPageTitleView: UIView {
    
    // MARK: - 定义属性
    fileprivate var titles : [String]
    
    // MARK: - 懒加载属性
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
        }()
    
    // MARK: - 定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DYPageTitleView {
    
    fileprivate func setupUI() {
        
        // 1.添加scrollview
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应的lable
        setupTitleLables()
        
        // 3.设置底线和滚动的滑块
    }
    
    fileprivate func setupTitleLables() {
        
        let lableW : CGFloat = frame.width / CGFloat(titles.count)
        let lableH : CGFloat = frame.height - kScrollLineH
        let lableY : CGFloat = 0
        
        
        
        for (index, title) in titles.enumerated() {
            // 1.创建lable
            let lable = UILabel()
            
            // 2.设置lable的属性
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textAlignment = .center
            
            // 3.设置lable的frame
            let lableX = lableW * CGFloat(index)
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            
            // 4.将lable添加到scrollview中
            scrollView.addSubview(lable)
            
        }
    }
}
