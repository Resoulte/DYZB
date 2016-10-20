//
//  DYHomeViewController.swift
//  DYZB
//
//  Created by ma c on 16/10/20.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYHomeViewController: UIViewController {

    // MARK: -系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
    }
    
    
}

// MARK: -设置导航栏内容
extension DYHomeViewController {
    // MARK: 设置导航栏
    fileprivate func setupUI() {
        // 设置导航栏
        setupNavBarItem2()
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
        let size = CGSize(width: 36, height: 36)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem(image: "logo")
        
        let historyItem = UIBarButtonItem.creatBarButtonItem(image: "image_my_history", higlighted: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem.creatBarButtonItem(image: "btn_search", higlighted: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem.creatBarButtonItem(image: "Image_scan", higlighted: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
    /*
     扩充遍历构造函数（推荐做法）
     
     遍历构造函数特点
     构造函数前以convenience开头
     必须明确调用设计构造函数：例如self.init()
     */
    private func setupNavBarItem2() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "logo")
        
        
        let size = CGSize(width: 36, height: 36)
        let historyItem = UIBarButtonItem(image: "image_my_history", highlighted: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(image: "btn_search", highlighted: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(image: "Image_scan", highlighted: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
        
        
    }
}
