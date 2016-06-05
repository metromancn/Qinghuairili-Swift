//
//  WQPGlobal.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit

enum MainButtonType {
    case History
    case Calendar
    case Setting
    case Share
}

//Template
struct Template
{
    static let IMAGE_HEIGHT_4  = 256
    static let IMAGE_HEIGHT_5  = 256
    static let IMAGE_HEIGHT_6  = 300
    static let IMAGE_HEIGHT_6P = 331
    
    static let TEXT_TOP_4  = 10
    static let TEXT_TOP_5  = 10
    static let TEXT_TOP_6  = 10
    static let TEXT_TOP_6P = 10
    
    static let TEXT_BOTTOM_4  = 10
    static let TEXT_BOTTOM_5  = 10
    static let TEXT_BOTTOM_6  = 10
    static let TEXT_BOTTOM_6P = 10
    
    static func getImageHeight() -> Int {
        var result = 0
        if DeviceType.IS_IPHONE_4_OR_LESS {
            result = IMAGE_HEIGHT_4
        } else if DeviceType.IS_IPHONE_5 {
            result = IMAGE_HEIGHT_5
        } else if DeviceType.IS_IPHONE_6 {
            result = IMAGE_HEIGHT_6
        } else if DeviceType.IS_IPHONE_6P {
            result = IMAGE_HEIGHT_6P
        }
        return result;
    }
    
    static func getTextTopSpace() -> Int {
        var result = 0
        if DeviceType.IS_IPHONE_4_OR_LESS {
            result = TEXT_TOP_4
        } else if DeviceType.IS_IPHONE_5 {
            result = TEXT_TOP_5
        } else if DeviceType.IS_IPHONE_6 {
            result = TEXT_TOP_6
        } else if DeviceType.IS_IPHONE_6P {
            result = TEXT_TOP_6P
        }
        return result;
    }
    
    static func getTextBottomSpace() -> Int {
        var result = 0
        if DeviceType.IS_IPHONE_4_OR_LESS {
            result = TEXT_BOTTOM_4
        } else if DeviceType.IS_IPHONE_5 {
            result = TEXT_BOTTOM_5
        } else if DeviceType.IS_IPHONE_6 {
            result = TEXT_BOTTOM_6
        } else if DeviceType.IS_IPHONE_6P {
            result = TEXT_BOTTOM_6P
        }
        return result;
    }
}

//Tool
struct Tool
{
    static func getImage() -> UIImage! {
        var result = ""
        if DeviceType.IS_IPHONE_4_OR_LESS {
            result = "bg_calendar_tool_320.png"
        } else if DeviceType.IS_IPHONE_5 {
            result = "bg_calendar_tool_320.png"
        } else if DeviceType.IS_IPHONE_6 {
            result = "bg_calendar_tool_375.png"
        } else if DeviceType.IS_IPHONE_6P {
            result = "bg_calendar_tool_414.png"
        }
        return UIImage(named: result)
    }
    
    static func getRange(index: Int) -> Int {
        var result = 0
        if DeviceType.IS_IPHONE_4_OR_LESS {
            if index == 0 {
                result = 70
            } else if index == 1 {
                result = 140
            } else if index == 2 {
                result = 210
            }
        } else if DeviceType.IS_IPHONE_5 {
            if index == 0 {
                result = 70
            } else if index == 1 {
                result = 140
            } else if index == 2 {
                result = 210
            }
        } else if DeviceType.IS_IPHONE_6 {
            if index == 0 {
                result = 70
            } else if index == 1 {
                result = 150
            } else if index == 2 {
                result = 220
            }
        } else if DeviceType.IS_IPHONE_6P {
            if index == 0 {
                result = 80
            } else if index == 1 {
                result = 160
            } else if index == 2 {
                result = 250
            }
        }
        return result
    }
}

//Weather
enum WeatherType: String {
    case Sunny = "晴"
    case Rainy = "雨"
    case Snowy = "雪"
    case Cloudy = "云"
    case Windy = "风"
    
    static let allValues = [Sunny, Rainy, Snowy, Cloudy, Windy]
    
    static let WEATHER_PRE  = "- "
    static let WEATHER_SUF  = " -"
    
    static func getWeatherType(text: String) -> WeatherType {
        var result = WeatherType.Sunny
        for obj in allValues {
            if text == getWeatherStr(obj) {
                result = obj
                break
            }
        }
        return result
    }
    
    static func getWeatherIndex(text: String) -> Int {
        var result = 0
        for obj in allValues {
            if text == getWeatherStr(obj) {
                break
            }
            result = result + 1
        }
        return result
    }
    
    static func getWeatherStr(type: WeatherType) -> String {
        return "\(WEATHER_PRE)\(type.rawValue)\(WEATHER_SUF)"
    }
}

//Demo
struct Demo
{
    static let GOOD_PRE  = "宜 | "
    static let BAD_PRE   = "忌 | "
    
    static let IMAGE_1    = "demo1.jpg"
    static let CONTENT_1  = "用情怀照亮生活的每一天"
    static let GOOD_1     = "朝着夕阳奔跑"
    static let BAD_1      = "像咸鱼一样"
    
    static let IMAGE_2    = "demo2.jpg"
    static let CONTENT_2  = "AMANI\n向世界呼唤爱"
    static let GOOD_2     = "和平"
    static let BAD_2      = "战争"
    
    static let IMAGE_3    = "demo3.jpg"
    static let CONTENT_3  = "你赤手空拳来到人世间\n为找到那片海奋不顾身"
    static let GOOD_3     = "敢作敢为"
    static let BAD_3      = "畏首畏尾"
    
    static let IMAGE_4    = "demo4.jpg"
    static let CONTENT_4  = "城市里应该有鲜花"
    static let GOOD_4     = "使用情怀日历"
    static let BAD_4      = "一成不变"
    
    static let IMAGE_5    = "demo5.jpg"
    static let CONTENT_5  = "隐约雷鸣阴霾天空\n但盼风雨来\n能留你在此地"
    static let GOOD_5     = "死皮赖脸"
    static let BAD_5      = "无动于衷"
    
    static let IMAGE_6    = "demo6.jpg"
    static let CONTENT_6  = "男人爱女人的最好方式\n就是不让自己的女人觉得无聊"
    static let GOOD_6     = "花样百出"
    static let BAD_6      = "高冷死鱼"
    
    static let IMAGE_7    = "demo7.jpg"
    static let CONTENT_7  = "我当然不会试图摘月\n我要使月亮奔我而来"
    static let GOOD_7     = "傲娇"
    static let BAD_7      = "千里送"
    
    static let IMAGE_8    = "demo8.jpg"
    static let CONTENT_8  = "睡眠是大自然神奇的秘密\n他恢复人的一切力量\n肉体的精神的"
    static let GOOD_8     = "安眠"
    static let BAD_8      = "熬夜"
    
    static let IMAGE_9    = "demo9.jpg"
    static let CONTENT_9  = "如果你独自一人\n你就彻底属于你自己\n如果你和其他人在一起\n你就只有一半属于自己\n甚至不到一半"
    static let GOOD_9     = "落单"
    static let BAD_9      = "失去自我"
    
    static let IMAGE_10   = "demo10.jpg"
    static let CONTENT_10 = "对这些都倦了\n我要离开这人间\n只是，我死了\n要使我的爱人孤单了"
    static let GOOD_10    = "厮守"
    static let BAD_10     = "放弃生命"
    
    static var demoValue = 1
    
    static func randomDemo() {
        demoValue = Int(arc4random_uniform(10)) + 1
    }
    
    static func getImage(index: Int? = nil) -> UIImage! {
        var result = IMAGE_1
        let demoIndex = index == nil ? demoValue : 1
        if demoIndex == 1 {
            result = IMAGE_1
        } else if demoIndex == 2 {
            result = IMAGE_2
        } else if demoIndex == 3 {
            result = IMAGE_3
        } else if demoIndex == 4 {
            result = IMAGE_4
        } else if demoIndex == 5 {
            result = IMAGE_5
        } else if demoIndex == 6 {
            result = IMAGE_6
        } else if demoIndex == 7 {
            result = IMAGE_7
        } else if demoIndex == 8 {
            result = IMAGE_8
        } else if demoIndex == 9 {
            result = IMAGE_9
        } else if demoIndex == 10 {
            result = IMAGE_10
        }
        return UIImage(named: result)
    }
    
    static func getContent(index: Int? = nil) -> String {
        var result = CONTENT_1
        let demoIndex = index == nil ? demoValue : 1
        if demoIndex == 1 {
            result = CONTENT_1
        } else if demoIndex == 2 {
            result = CONTENT_2
        } else if demoIndex == 3 {
            result = CONTENT_3
        } else if demoIndex == 4 {
            result = CONTENT_4
        } else if demoIndex == 5 {
            result = CONTENT_5
        } else if demoIndex == 6 {
            result = CONTENT_6
        } else if demoIndex == 7 {
            result = CONTENT_7
        } else if demoIndex == 8 {
            result = CONTENT_8
        } else if demoIndex == 9 {
            result = CONTENT_9
        } else if demoIndex == 10 {
            result = CONTENT_10
        }
        return result
    }
    
    static func getGood(index: Int? = nil) -> String {
        var result = GOOD_1
        let demoIndex = index == nil ? demoValue : 1
        if demoIndex == 1 {
            result = GOOD_1
        } else if demoIndex == 2 {
            result = GOOD_2
        } else if demoIndex == 3 {
            result = GOOD_3
        } else if demoIndex == 4 {
            result = GOOD_4
        } else if demoIndex == 5 {
            result = GOOD_5
        } else if demoIndex == 6 {
            result = GOOD_6
        } else if demoIndex == 7 {
            result = GOOD_7
        } else if demoIndex == 8 {
            result = GOOD_8
        } else if demoIndex == 9 {
            result = GOOD_9
        } else if demoIndex == 10 {
            result = GOOD_10
        }
        return "\(GOOD_PRE)\(result)"
    }
    
    static func getBad(index: Int? = nil) -> String {
        var result = BAD_1
        let demoIndex = index == nil ? demoValue : 1
        if demoIndex == 1 {
            result = BAD_1
        } else if demoIndex == 2 {
            result = BAD_2
        } else if demoIndex == 3 {
            result = BAD_3
        } else if demoIndex == 4 {
            result = BAD_4
        } else if demoIndex == 5 {
            result = BAD_5
        } else if demoIndex == 6 {
            result = BAD_6
        } else if demoIndex == 7 {
            result = BAD_7
        } else if demoIndex == 8 {
            result = BAD_8
        } else if demoIndex == 9 {
            result = BAD_9
        } else if demoIndex == 10 {
            result = BAD_10
        }
        return "\(BAD_PRE)\(result)"
    }
}