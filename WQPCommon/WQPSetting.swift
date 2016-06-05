//
//  WQPSetting.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit

class WQPSetting {
    static let KEY_GAD_COUNT = "KEY_GAD_COUNT"
    static let SETTING = NSUserDefaults.standardUserDefaults()
    
    static func registKey() {
        if !SETTING.dictionaryRepresentation().keys.contains(KEY_GAD_COUNT) {
            SETTING.registerDefaults([KEY_GAD_COUNT: 0])
            SETTING.synchronize()
        }
    }
    
    static func addGadCount() {
        var gadCount = SETTING.integerForKey(KEY_GAD_COUNT)
        gadCount = gadCount + 1
        SETTING.setInteger(gadCount, forKey: KEY_GAD_COUNT)
        SETTING.synchronize()
    }
    
    static func getGadCount() -> Int {
        return SETTING.integerForKey(KEY_GAD_COUNT)
    }
}