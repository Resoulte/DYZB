//
//  DYFunnyViewModel.swift
//  DYZB
//
//  Created by 师飞 on 2017/3/4.
//  Copyright © 2017年 shifei. All rights reserved.
//

import UIKit

class DYFunnyViewModel : DYBaseViewModel {

}

extension DYFunnyViewModel {
    func loadFunnyData(finishedCallback :  @escaping() -> ()) {
        loadAnchorsData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", params: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    } 
}
