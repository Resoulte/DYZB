//
//  DYPrettyCollectionViewCell.swift
//  DYZB
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit
import Kingfisher

class DYPrettyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlinename: UIButton!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var cityName: UIButton!
    
    var anchor : DYAnchorItem? {
        didSet {
            cityName.setTitle(anchor?.anchor_city, for: .normal)
            nickName.text = anchor?.nickname
            onlinename.setTitle("\((anchor?.online)!)人在线", for: .normal)
            
            guard let urlStr = URL(string : (anchor?.vertical_src)!) else {
                return
            }
            iconImageView.kf.setImage(with: urlStr)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
