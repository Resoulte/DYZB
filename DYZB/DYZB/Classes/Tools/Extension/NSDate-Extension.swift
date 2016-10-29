//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 shifei. All rights reserved.
//

import Foundation
extension Date {

    static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
        
    }
    
    
}
