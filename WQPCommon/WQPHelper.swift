//
//  MCHelper.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit

class WQPHelper {
    //URL
    static func openURL(url: String) -> Void {
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    //Style
    static func styleCell(tableView: UITableView, identifier: String, style: UITableViewCellStyle, accessory: UITableViewCellAccessoryType) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: style, reuseIdentifier: identifier)
        }
        cell?.accessoryType = accessory
        cell?.textLabel?.font = UIFont.systemFontOfSize(17)
        cell?.textLabel?.text = ""
        cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
        cell?.detailTextLabel?.textColor = UIColor.fromRGB(142, 142, 147)
        cell?.detailTextLabel?.text = ""
        return cell;
    }
    
    //Other
    static func getBackBar() -> UIBarButtonItem {
        let result = UIBarButtonItem()
        result.title = ""
        return result
    }
}
