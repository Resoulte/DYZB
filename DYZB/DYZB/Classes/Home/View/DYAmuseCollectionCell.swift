//
//  DYAmuseCollectionCell.swift
//  DYZB
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class DYAmuseCollectionCell: UICollectionViewCell {

    var groups : [DYAnchorGroupItem]? {
        
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "DYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let  itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
    }
}


extension DYAmuseCollectionCell : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! DYCollectionGameCell
//        cell.backgroundColor = UIColor.randomColor()
        cell.baseItem = groups?[indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
}
