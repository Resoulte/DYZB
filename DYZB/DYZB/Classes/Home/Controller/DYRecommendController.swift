//
//  DYRecommendController.swift
//  DYZB
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

// MARK: -定义常量


private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90.0





class DYRecommendController: DYBaseViewController {

    // MARK: -懒加载
    lazy var recommendVM = DYRecommendViewModel()
     lazy var cycleView : DYRecommendCycleView = {
        
        let cycleView = DYRecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
        
    }()
    
    lazy var gameView : DYRecommendGameView = {
        let gameView = DYRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
    }()
    // MARK: -系统回调的方法
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadCycleData()
    }

}

// MARK: - 设置UI界面
extension DYRecommendController {
    
   override func setupUI() {
    
        super.setupUI()
        collection.delegate = self
        // 1.将UICollectionView加入控制器view当中
        view.addSubview(collection)
    
        // 2.将cycleView加到collectionview
        collection.addSubview(cycleView)
    
        // 将gameView加到collectionview
        collection.addSubview(gameView)
    
        // 3.设置collectionview的内边距
        collection.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 请求数据
extension DYRecommendController {
    // 请求推荐数据
    override func loadData() {
        // 1.给父类中的viewmodel赋值
        baseVM = recommendVM
        // 2.发送请求
        recommendVM.requestData {
            self.collection.reloadData()
            
            // 将数据传给gameView
            var groups = self.recommendVM.anchorGroups
            // 1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            // 添加更多
            let moreGroup = DYAnchorGroupItem()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
        }
        
        self.loadFinishedData()
    }
    
    // 请求轮播数据
    fileprivate func loadCycleData() {
        recommendVM.requestCycleData {
            self.cycleView.cycleItems = self.recommendVM.cycleItems
        }
    }
    
}

extension DYRecommendController : UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
    
    if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyID, for: indexPath) as! DYPrettyCollectionViewCell
            cell.anchor = anchor
            return cell
        } else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalID, for: indexPath) as! DYNormalCollectionViewCell
            cell.anchor = anchor
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        } else {
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
    }
}

