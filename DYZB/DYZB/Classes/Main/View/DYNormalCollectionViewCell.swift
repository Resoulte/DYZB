//
//  DYNormalCollectionViewCell.swift
//  DYZB
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYNormalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var roomName: UILabel!
    
     var anchor : DYAnchorItem? {
        didSet {
            guard let urlStr = URL(string: (anchor?.vertical_src)!) else {
                return
            }
            iconImageView.kf.setImage(with: urlStr)
            var onlineStr = ""
            if (anchor?.online)! > 10000 {
                onlineStr = "\(Int((anchor?.online)! / 10000))万人在线"
            } else {
                onlineStr = "\((anchor?.online)!)人在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            nickName.text = anchor?.nickname
            roomName.text = anchor?.room_name
        }
    }
    
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
    }

}
