//
//  DYGameViewModel.swift
//  DYZB
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYGameViewModel {
    
    // MARK: - 懒加载
    fileprivate lazy var gameItem = DYGameItem()
    lazy var gameItems : [DYGameItem] = [DYGameItem]()
}


// MARK: - 请求游戏数据
extension DYGameViewModel {
    func requestGameData(finishedCallBack: @escaping () -> ()) {
        DYNetWorksTools.requestJsonData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", params: ["shortName" : "game"]) { (json) in
            print(json)
            // 将json转换为字典
            guard let jsonDict = json as? [String : Any] else { return }
            guard let dataArray = jsonDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                let game = DYGameItem(dict: dict)
                self.gameItems.append(game)
            }
            
            finishedCallBack()
        }
    }
}
