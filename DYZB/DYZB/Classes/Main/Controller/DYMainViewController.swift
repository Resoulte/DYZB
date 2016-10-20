//
//  DYMainViewController.swift
//  DYZB
//
//  Created by ma c on 16/10/20.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewController("Home")
        setupChildViewController("Live")
        setupChildViewController("Follow")
        setupChildViewController("Profile")
        
    }
    
    private func setupChildViewController(_ bundleName : String) {
        let vcName = UIStoryboard(name: bundleName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(vcName)
    }


}


