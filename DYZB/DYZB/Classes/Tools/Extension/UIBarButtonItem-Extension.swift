//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by ma c on 16/10/20.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    
    // 给系统类扩充类方法
    class func creatBarButtonItem(image: String, higlighted: String = "", size: CGSize = CGSize.zero, target : AnyObject? = nil, action : Selector) -> UIBarButtonItem {
        // 1.创建btn
        let btn = UIButton(type: .custom)
        
        // 2.给btn设置属性
        btn.setImage(UIImage(named: image), for: .normal)
        if higlighted != "" {
             btn.setImage(UIImage(named: higlighted), for: .highlighted)
        }
        
        // 3.设置尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        // 4.监听点击
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        return UIBarButtonItem(customView: btn)
    }
    
    
    
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(image: String, highlighted: String = "", size: CGSize = CGSize.zero, target : AnyObject? = nil, action : Selector) {
        let btn = UIButton(type: .custom)
        
        btn.setImage(UIImage(named: image), for: .normal)
        if highlighted != "" {
            
            btn.setImage(UIImage(named: highlighted), for: .highlighted)
        }
        
        if size == CGSize.zero {
        
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: btn)
    }
}
