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
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// MARK: - 定义PageTitleView类
class DYPageTitleView: UIView {
    
    // MARK: - 定义属性
    fileprivate var titles : [String]
    
    // MARK: - 懒加载属性
    fileprivate lazy var titleLables : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
        }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
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
//        scrollView.backgroundColor = UIColor.red
        
        // 2.添加title对应的lable
        setupTitleLables()
        
        // 3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
        
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
            titleLables.append(lable)
            
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        
        // 1.添加底线
        let bottomLine = UIView()
        let lineH : CGFloat = 0.5
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 2.1.获取第一个Lable
        guard let firstLable = titleLables.first else {
            return
        }
         firstLable.textColor = UIColor.orange
        
        
        
        // 2.2.设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y: frame.height - kScrollLineH, width: firstLable.frame.width, height: kScrollLineH)
        
        
        
    }
}
