//
//  ImageVC.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit

class ImageVC: UIViewController, UIActionSheetDelegate {
    var index = 0
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = WQPHelper.getBackBar()
        self.navigationItem.title = "我的日历"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "分享", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ImageVC.buttonAction(_:)))
        //CollectionView
        self.imageView = UIImageView(frame: UIScreen.mainScreen().bounds)
        self.imageView.contentMode = .ScaleAspectFit
        WQPPhoto.sharedInstance.fetchImage(self.imageView, index: self.index, isFullSize: true)
        self.view.addSubview(self.imageView)
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
    
    func buttonAction(sender: AnyObject) {
        WQPShare.showShareActionSheet("分享日历", vc: self, view: self.view)
    }
    
    //UIActionSheetDelegate
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            WQPShare.shareCalendarByWeibo(self, image: self.imageView.image!, text: "\(NSDate().getYMDStr())")
        } else if buttonIndex == 1 {
            WQPShare.shareCalendarByWeChat(self, image: self.imageView.image!)
        }
    }
    
    func actionSheetCancel(actionSheet: UIActionSheet) {
    }
}
