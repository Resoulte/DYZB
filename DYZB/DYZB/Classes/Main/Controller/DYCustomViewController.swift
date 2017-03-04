//
//  DYCustomViewController.swift
//  DYZB
//
//  Created by 师飞 on 2017/3/4.
//  Copyright © 2017年 shifei. All rights reserved.
//

import UIKit

class DYCustomViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 系统pop->view->target/action
        // 自定义pan->view->target/action
        // 1.取出手势,获取系统的pop手势
        guard let systeamGrsture = interactivePopGestureRecognizer else {
            return
        }
        
        // 2.获取添加手势的view
        guard let gestureView = systeamGrsture.view else {
            return
        }
        
        // 3.获取target/action
        // 3.1利用运行时机制获得所有的属性名称
        
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
        for i in 0..<count {
            let ivar = ivars?[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        
        let targets =  systeamGrsture.value(forKey: "_targets") as? [NSObject]
        guard let targetObject = targets?.first else {
            return
        }
        print(targetObject)
        
        // 3.2 取出target
        guard let target = targetObject.value(forKey: "target") else {return}
//        guard let action = targetObject.value(forKey: "action") as? Selector else {return}
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的新的pan手势
        let panGesture = UIPanGestureRecognizer()
        gestureView.addGestureRecognizer(panGesture)
        panGesture.addTarget(target, action: action)
        
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
