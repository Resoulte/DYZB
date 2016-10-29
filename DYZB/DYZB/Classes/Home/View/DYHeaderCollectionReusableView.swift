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
