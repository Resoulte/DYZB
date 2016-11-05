//
//  DYHeaderCollectionReusableView.swift
//  DYZB
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var icon_name: UIImageView!
    @IBOutlet weak var tag_name: UILabel!
    @IBOutlet weak var headerBtn: UIButton!
    // 定义模型属性
    var group : DYAnchorGroupItem? {
        didSet {
            icon_name.image = UIImage(named: group?.icon_name ?? "home_header_normal")
            tag_name.text = group?.tag_name
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

// MARK: - 提供快速创建的方法
extension DYHeaderCollectionReusableView {
   class func loadHeaderView() -> DYHeaderCollectionReusableView {
        return Bundle.main.loadNibNamed("DYHeaderCollectionReusableView", owner: nil, options: nil)?.first as! DYHeaderCollectionReusableView
    }
}
