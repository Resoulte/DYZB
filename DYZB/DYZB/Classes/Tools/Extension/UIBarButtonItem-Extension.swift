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
    class func creatBarButtonItem(image: String, higlighted: String = "", size: CGSize = CGSize.zero) -> UIBarButtonItem {
        // 1.创建btn
        let btn = UIButton(type: .custom)
        
        // 2.给btn设置属性
        btn.setImage(UIImage(named: image), for: .normal)
        if higlighted != "" {
             btn.setImage(UIImage(named: higlighted), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        return UIBarButtonItem(customView: btn)
    }
    
    
    
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(image: String, highlighted: String = "", size: CGSize = CGSize.zero) {
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
        
        self.init(customView: btn)
    }
}
