//
//  DYAllBaseViewController.swift
//  DYZB
//
//  Created by 师飞 on 2017/3/4.
//  Copyright © 2017年 shifei. All rights reserved.
//

import UIKit

class DYAllBaseViewController: UIViewController {

    // 定义属性
    var contentionView : UIView?
    
    
    // MARK: 懒加载属性
    fileprivate lazy var animationImageView : UIImageView = { [unowned self] in
   
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
//        imageView.center = (self?.view.center)!
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.25
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
  }()
    
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
}

extension DYAllBaseViewController {
    func setupUI() {
        
        // 1.隐藏内容view
        contentionView?.isHidden = true

        // 2.添加执行动画的UI
        self.view.addSubview(animationImageView)
        
        // 3.执行动画
        animationImageView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
            }
    
    func loadFinishedData() {
        
        animationImageView.stopAnimating()
        
        contentionView?.isHidden = false
        
        animationImageView.isHidden = true
    }
}
