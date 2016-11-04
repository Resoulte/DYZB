//
//  DYCollectionGameCell.swift
//  DYZB
//
//  Created by ma c on 16/10/30.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYCollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var iconGameView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    // MARK: - 定义模型属性
    var baseItem : DYBaseItem? {
        didSet {
            titleLable.text = baseItem?.tag_name
            if let urlStr = URL(string: baseItem?.icon_url ?? "") {
            iconGameView.kf.setImage(with: urlStr)
            } else {
                iconGameView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
