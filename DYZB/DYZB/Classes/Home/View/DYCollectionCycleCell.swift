//
//  DYCollectionCycleCell.swift
//  DYZB
//
//  Created by ma c on 16/10/30.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYCollectionCycleCell: UICollectionViewCell {

    // MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    var cycleItem : DYCycleItem? {
    
        didSet {
            let urlStr = URL(string: cycleItem?.pic_url ?? "")
            iconImageView.kf.setImage(with: urlStr)
            titleLable.text = cycleItem?.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
