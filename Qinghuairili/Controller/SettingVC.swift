//
//  SettingVC.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit

class SettingVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = WQPHelper.getBackBar()
        self.navigationItem.title = "设置"
        tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.None)
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
        self.navigationController?.navigationBarHidden = true
    }
    
    //UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = 0;
        if section == 0 {
            result = 2
        } else if section == 1 {
            result = 2
        }
        return result
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var result = ""
        if section == 0 {
            result = "建议与反馈"
        } else if section == 1 {
            result = "情怀日历官方粉丝"
        }
        return result
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = WQPHelper.styleCell(tableView, identifier: "", style: UITableViewCellStyle.Default, accessory: UITableViewCellAccessoryType.DisclosureIndicator)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "评个分吧"
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "我要吐槽"
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "QQ群"
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "关注微博"
            }
        }
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                WQPHelper.openURL("itms-apps://itunes.apple.com/app/id1109727871")
            } else if indexPath.row == 1 {
                let appVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]!
                let subject = "[反馈]情怀日历V\(appVersion)(\(DeviceType.getDeviceName())_\(Version.iOSVersion))"
                WQPHelper.openURL("mailto:qinghuairili@163.com?subject=\(subject)&body=".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                WQPHelper.openURL("mqqapi://card/show_pslcard?src_type=internal&version=1&uin=238902383&card_type=group&source=external")
            } else if indexPath.row == 1 {
                WQPHelper.openURL("http://www.weibo.com/qinghuairili")
            }
        }
    }
}
