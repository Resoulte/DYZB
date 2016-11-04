//
//  DYHomeViewController.swift
//  DYZB
//
//  Created by ma c on 16/10/20.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

let kTitleViewH : CGFloat = 40.0


class DYHomeViewController: UIViewController {

    // MARK: -懒加载属性
    fileprivate lazy var pageTitleView :DYPageTitleView = {[weak self] in
        
        let titleFrame = CGRect(x: 0.0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = DYPageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        
        }()
    
    fileprivate lazy var pageContentView : DYPageContentView = {[weak self] in
        
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        
        // 2.确定所有的子控制器
        var childVCs = [UIViewController]()
        childVCs.append(DYRecommendController())
        childVCs.append(DYGameViewController())
        for _ in 0..<2 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            childVCs.append(vc)
        }
        
        let contentView = DYPageContentView(frame: contentFrame, childVcs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    // MARK: -系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
        
     
    }
    
    
}



// MARK: -设置UI界面
extension DYHomeViewController {
    // MARK: 设置导航栏
    fileprivate func setupUI() {
        
        // 不需要调整scrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavBarItem2()
        
        // 2.添加titleView
        view.addSubview(pageTitleView)
        
        // 3.添加ContenView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.red
    
    }
    
    // 直接设置的方法(low)
    private func setupNavBarItem() {
        
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named:"logo"), for: .normal)
        leftBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        let size = CGSize(width: 36, height: 36)
        
        // 历史
        let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
        historyBtn.setImage(UIImage(named: "Image_my_history_click"), for: .highlighted)
        
        historyBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let historyItem = UIBarButtonItem(customView: historyBtn)
        
        // 搜索
        let searchBtn = UIButton()
        searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
        searchBtn.setImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
//        searchBtn.sizeToFit()
        searchBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let searchItem = UIBarButtonItem(customView: searchBtn)
        
        // 二维码
        let qrcodeBtn = UIButton()
        qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
        qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
//        qrcodeBtn.sizeToFit()
        qrcodeBtn.frame = CGRect(origin: .zero, size: size)
        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
    /* 设置类别的方法（只需创建swift原文件）
    在OC中我们通常给系统的类抽取分类，在分类中给系统的类扩充方法
    Swift也是类似，只是Swift使用extension，表示对系统的类进行扩充
     */
    private func setupNavBarItem1() {
//        let size = CGSize(width: 36, height: 36)
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem(image: "logo")
//        
//        let historyItem = UIBarButtonItem.creatBarButtonItem(image: "image_my_history", higlighted: "Image_my_history_click", size: size)
//        
//        let searchItem = UIBarButtonItem.creatBarButtonItem(image: "btn_search", higlighted: "btn_search_clicked", size: size)
//        
//        let qrcodeItem = UIBarButtonItem.creatBarButtonItem(image: "Image_scan", higlighted: "Image_scan_click", size: size)
//        
//        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
    /*
     扩充遍历构造函数（推荐做法）
     
     遍历构造函数特点
     构造函数前以convenience开头
     必须明确调用设计构造函数：例如self.init()
     */
    private func setupNavBarItem2() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "logo", target: self, action: #selector(self.leftItemClick))
        
        
        let size = CGSize(width: 36, height: 36)
        
        let historyItem = UIBarButtonItem(image: "image_my_history", highlighted: "Image_my_history_click", size: size, target: self, action: #selector(self.historyItemClick))
        
        let searchItem = UIBarButtonItem(image: "btn_search", highlighted: "btn_search_clicked", size: size, target: self, action: #selector(self.searchItemClick))
        
        let qrcodeItem = UIBarButtonItem(image: "Image_scan", highlighted: "btn_search_clicked", size: size, target: self, action: #selector(self.qrcodeItemClick))
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
        
        
    }
    
    // 导航栏的事件处理
    
    @objc private func leftItemClick() {
        print("点击了logo")
    }
    
    @objc private func historyItemClick() {
        print("点击了历史")
    }
    
    @objc private func searchItemClick() {
        print("点击了搜索")
    }
    
    @objc private func qrcodeItemClick() {
        print("点击了二维码")
    }
}

// MARK: -PageTitleViewDelegate
extension DYHomeViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: DYPageTitleView, selectedIndex index: Int) {
        
        pageContentView.setCurrentIndex(index)
    }
    
}

// MARK: -PageContentViewDelegate
extension DYHomeViewController : PageContentViewDelegate {
    
    func pageContentView(contentView: DYPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.setTitleView(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
