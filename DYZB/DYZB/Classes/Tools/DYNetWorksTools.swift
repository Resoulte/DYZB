//
//  DYNetWorksTools.swift
//  DYZB
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 shifei. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class DYNetWorksTools {
    class func requestJsonData(type: MethodType, URLString: String, params:[String : Any]? = nil, finishedCallBack: @escaping (_ result: Any) -> ()) {
        let method = type == .get ? HTTPMethod
            .get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: params).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            finishedCallBack(result)
        }
        
    }
}
