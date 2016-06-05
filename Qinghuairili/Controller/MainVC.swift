//
//  MainVC.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit
import Photos

class MainVC: UIViewController, UIActionSheetDelegate, UIAlertViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = WQPHelper.getBackBar()
        if DeviceType.IS_IPHONE_4_OR_LESS {
            addTextImage(CGRect(x: 20, y: 20, width: 116, height: 74))
            addButton(.History, frame: CGRect(x: 20, y: 100, width: 130, height: 130))
            addButton(.Calendar, frame: CGRect(x: 170, y: 100, width: 130, height: 130))
            addButton(.Setting, frame: CGRect(x: 20, y: 250, width: 130, height: 130))
            addButton(.Share, frame: CGRect(x: 170, y: 250, width: 130, height: 130))
        } else if DeviceType.IS_IPHONE_5 {
            addTextImage(CGRect(x: 20, y: 20, width: 116, height: 74))
            addButton(.History, frame: CGRect(x: 20, y: 144, width: 130, height: 130))
            addButton(.Calendar, frame: CGRect(x: 170, y: 144, width: 130, height: 130))
            addButton(.Setting, frame: CGRect(x: 20, y: 294, width: 130, height: 130))
            addButton(.Share, frame: CGRect(x: 170, y: 294, width: 130, height: 130))
        } else if DeviceType.IS_IPHONE_6 {
            addTextImage(CGRect(x: 20, y: 20, width: 116, height: 74))
            addButton(.History, frame: CGRect(x: 25, y: 171, width: 150, height: 150))
            addButton(.Calendar, frame: CGRect(x: 200, y: 171, width: 150, height: 150))
            addButton(.Setting, frame: CGRect(x: 25, y: 346, width: 150, height: 150))
            addButton(.Share, frame: CGRect(x: 200, y: 346, width: 150, height: 150))
        } else if DeviceType.IS_IPHONE_6P {
            addTextImage(CGRect(x: 20, y: 20, width: 116, height: 74))
            addButton(.History, frame: CGRect(x: 30, y: 191, width: 162, height: 162))
            addButton(.Calendar, frame: CGRect(x: 222, y: 191, width: 162, height: 162))
            addButton(.Setting, frame: CGRect(x: 30, y: 383, width: 162, height: 162))
            addButton(.Share, frame: CGRect(x: 222, y: 383, width: 162, height: 162))
        }
        //Photo
        WQPPhoto.sharedInstance.initAlbum()
    }
    
    func addTextImage(frame: CGRect) {
        let textImage = UIImageView(frame: frame)
        textImage.image = UIImage(named: "bg_main_text.png")
        textImage.contentMode = .ScaleAspectFit
        view.addSubview(textImage)
    }
    
    func addButton(buttonType: MainButtonType, frame: CGRect) {
        let button = UIButton(frame: frame)
        switch buttonType {
        case .History:
            button.setImage(UIImage(named: "ic_history.png"), forState: .Normal)
            button.setImage(UIImage(named: "ic_history_on.png"), forState: .Highlighted)
            button.tag = 1
        case .Calendar:
            button.setImage(UIImage(named: "ic_calendar.png"), forState: .Normal)
            button.setImage(UIImage(named: "ic_calendar_on.png"), forState: .Highlighted)
            button.tag = 2
        case .Setting:
            button.setImage(UIImage(named: "ic_setting.png"), forState: .Normal)
            button.setImage(UIImage(named: "ic_setting_on.png"), forState: .Highlighted)
            button.tag = 3
        case .Share:
            button.setImage(UIImage(named: "ic_share.png"), forState: .Normal)
            button.setImage(UIImage(named: "ic_share_on.png"), forState: .Highlighted)
            button.tag = 4
        }
        button.addTarget(self, action: #selector(MainVC.buttonAction(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    func buttonAction(sender: AnyObject) {
        if sender.tag == 1 {
            WQPPhoto.sharedInstance.initAlbum()
            WQPPhoto.sharedInstance.refreshPhotos()
            if WQPPhoto.sharedInstance.photoCount == 0 {
                let alertView = UIAlertView(title: "您还没有任何回忆哦\n请先创建日历", message: "", delegate: self, cancelButtonTitle: "残忍的拒绝", otherButtonTitles: "现在就去")
                
                alertView.show()
            } else {
                self.navigationController?.pushViewController(HistoryVC(nibName: "HistoryVC", bundle: nil), animated: true)
            }
        } else if sender.tag == 2 {
            Demo.randomDemo()
            self.navigationController?.pushViewController(CalendarVC(nibName: "CalendarVC", bundle: nil), animated: true)
        } else if sender.tag == 3 {
            self.navigationController?.pushViewController(SettingVC(nibName: "SettingVC", bundle: nil), animated: true)
        } else if sender.tag == 4 {
            WQPShare.showShareActionSheet("分享APP - 情怀日历", vc: self, view: self.view)
        }
    }
    
    //UIActionSheetDelegate
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            WQPShare.shareAppByWeibo(self)
        } else if buttonIndex == 1 {
            WQPShare.shareAppByWeChat(self)
        }
    }
    
    func actionSheetCancel(actionSheet: UIActionSheet) {
    }
    
    //UIAlertViewDelegate
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            self.navigationController?.pushViewController(HistoryVC(nibName: "HistoryVC", bundle: nil), animated: true)
        } else if buttonIndex == 1 {
            Demo.randomDemo()
            self.navigationController?.pushViewController(CalendarVC(nibName: "CalendarVC", bundle: nil), animated: true)
        }
    }
}
