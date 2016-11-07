//
//  DYAmuseViewModel.swift
//  DYZB
//
//  Created by ma c on 16/11/6.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit

class DYAmuseViewModel : DYBaseViewModel{
    
    
}

extension DYAmuseViewModel {
    func loadAmuseData(finishCalllBack: @escaping () -> ()) {
       loadAnchorsData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishCalllBack)
    }
}
