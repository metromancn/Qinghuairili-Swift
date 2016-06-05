//
//  WQPExtension.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit

extension UIColor {
    class func fromRGB(r: Int, _ g: Int, _ b: Int) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
}

extension UIFont {
    class func STFangsong(size: Int) -> UIFont {
        return UIFont(name: "STFangsong", size: CGFloat(size))!
    }
}

extension NSObject {
    var theClassName: String {
        return NSStringFromClass(self.dynamicType)
    }
}

extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func toast(message: String, duration: NSTimeInterval = 1.0, position: ToastPosition = .Center) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.view.makeToast(message, duration: duration, position: position)
        })
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSizeMake(1, 1)) {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(CGImage: image.CGImage!)
    }  
}

extension String {
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func lastIndexOf(s: String) -> Index? {
        if let r: Range<Index> = self.rangeOfString(s, options: .BackwardsSearch) {
            return r.startIndex
        }
        return Optional<Index>()
    }
}

extension NSDate {
    func getYearValue() -> Int? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Year, fromDate: self) else { return nil }
        return comp.year
    }
    
    func getMonthValue() -> Int? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Month, fromDate: self) else { return nil }
        return comp.month
    }
    
    func getDayValue() -> Int? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Day, fromDate: self) else { return nil }
        return comp.day
    }
    
    func getWeekValue() -> Int? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Weekday, fromDate: self) else { return nil }
        return comp.weekday
    }
    
    func getYMDStr() -> String {
        let dateFormat = NSDateFormatter()
        dateFormat.locale = NSLocale(localeIdentifier: "US")
        dateFormat.dateFormat = "yyyy年M月d日"
        return dateFormat.stringFromDate(NSDate())
    }
    
    func getWeekStr() -> String {
        var chineseWeek = ""
        let week = NSDate().getWeekValue()!
        switch week {
        case 1:
            chineseWeek = "日"
        case 2:
            chineseWeek = "一"
        case 3:
            chineseWeek = "二"
        case 4:
            chineseWeek = "三"
        case 5:
            chineseWeek = "四"
        case 6:
            chineseWeek = "五"
        case 7:
            chineseWeek = "六"
        default:
            chineseWeek = ""
        }
        return "星期\(chineseWeek)"
    }
}
