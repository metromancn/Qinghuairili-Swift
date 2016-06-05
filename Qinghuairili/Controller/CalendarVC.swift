//
//  CalendarVC.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit

class CalendarVC: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate {
    var needSaveAlert = false
    //ImageView
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    //ImageMark
    var yearLabel: UILabel!
    var watermarkLabel: UILabel!
    //TextView
    var textView: TextView!
    //ToolView
    var toolView: UIImageView!
    //ScreenImage
    var screenImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = WQPHelper.getBackBar()
        //ImageView
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: Int(ScreenSize.SCREEN_WIDTH), height: Template.getImageHeight()))
        self.scrollView.backgroundColor = UIColor.blackColor()
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)
        self.addImage(Demo.getImage())
        //ImageMark
        self.addYearLabel()
        self.addWatermarkLabel()
        //TextView
        self.textView = TextView()
        self.textView.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(CalendarVC.textTapped(_:))))
        self.view.addSubview(self.textView)
        //ToolView
        self.toolView = UIImageView(frame: CGRect(x: 0, y: ScreenSize.SCREEN_HEIGHT - 49, width: ScreenSize.SCREEN_WIDTH, height: 49))
        self.toolView.contentMode = .ScaleToFill
        self.toolView.image = Tool.getImage()
        self.view.addSubview(self.toolView)
        self.toolView.userInteractionEnabled = true
        let toolTap = UITapGestureRecognizer(target: self, action: #selector(CalendarVC.toolTap(_:)))
        toolTap.numberOfTapsRequired = 1
        toolTap.numberOfTouchesRequired = 1
        self.toolView.addGestureRecognizer(toolTap)
        //Photo
        WQPPhoto.sharedInstance.initAlbum()
    }
    
    //ImageView
    func addImage(image: UIImage) {
        if self.imageView != nil {
            self.imageView.removeFromSuperview()
            self.imageView = nil
        }
        self.imageView = UIImageView(image: image)
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(CalendarVC.imageTapped(_:))))
        self.scrollView.contentSize = image.size
        let widthZoomScale = self.scrollView.frame.width / image.size.width
        let heightZoomScale = self.scrollView.frame.height / image.size.height
        let minimumZoomScale = widthZoomScale < heightZoomScale ? heightZoomScale : widthZoomScale
        let maximumZoomScale = minimumZoomScale < 1.0 ? 1.0 : minimumZoomScale
        self.scrollView.minimumZoomScale = minimumZoomScale
        self.scrollView.maximumZoomScale = maximumZoomScale
        self.scrollView.setZoomScale(minimumZoomScale, animated: true)
        let offsetX = (self.scrollView.contentSize.width - self.scrollView.bounds.size.width) / 2
        let offsetY = (self.scrollView.contentSize.height - self.scrollView.bounds.size.height) / 2
        self.scrollView.contentOffset = CGPoint(x: offsetX, y: offsetY)
        self.scrollView.addSubview(self.imageView)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func imageTapped(obj: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.needSaveAlert = true
            self.addImage(pickedImage)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //ImageMark
    func addYearLabel() {
        yearLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        yearLabel.textAlignment = .Center
        yearLabel.font = UIFont.STFangsong(22)
        yearLabel.textColor = UIColor.whiteColor()
        yearLabel.text = "\(NSDate().getYearValue()!)"
        yearLabel.alpha = 0.8
        self.view.addSubview(yearLabel)
    }
    
    func addWatermarkLabel() {
        watermarkLabel = UILabel(frame: CGRect(x: 0, y: Template.getImageHeight() - 30, width: 100, height: 30))
        watermarkLabel.textAlignment = .Center
        watermarkLabel.font = UIFont.STFangsong(17)
        watermarkLabel.textColor = UIColor.whiteColor()
        watermarkLabel.text = "情怀日历"
        watermarkLabel.alpha = 0.8
        self.view.addSubview(watermarkLabel)
    }
    
    //TextView
    func textTapped(obj: AnyObject) {
        let inputVC = InputVC(nibName: "InputVC", bundle: nil)
        inputVC.calendarVC = self
        self.navigationController?.pushViewController(inputVC, animated: true)
    }
    
    //ToolView
    func toolTap(sender: UITapGestureRecognizer) {
        let point = sender.locationInView(toolView)
        let pointX = Int(point.x)
        if pointX < Tool.getRange(0) {
            if needSaveAlert {
                let alertView = UIAlertView(title: "还没制作完呢，您要放弃了吗", message: "", delegate: self, cancelButtonTitle: "继续", otherButtonTitles: "我要放弃")
                alertView.show()
            } else {
                self.navigationController?.popViewControllerAnimated(true)
            }
        } else if pointX < Tool.getRange(1) {
            imageTapped(sender)
        } else if pointX < Tool.getRange(2) {
            textTapped(sender)
        } else {
            self.screenImage = self.getScreenImage()
            if WQPPhoto.sharedInstance.album == nil {
                self.needSaveAlert = false
                WQPShare.showShareActionSheet(WQPPhoto.errMsg, vc: self, view: self.view)
            } else {
                WQPPhoto.sharedInstance.saveImage(self.screenImage!) { (success: Bool, error: NSError?) -> Void in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if success {
                            self.needSaveAlert = false
                            WQPShare.showShareActionSheet("已保存到相册 - 分享日历", vc: self, view: self.view)
                        } else {
                            self.toast("相册保存失败！错误描述：\(error)", duration: 0.5)
                        }
                    })
                }
            }
        }
    }

    //UIAlertViewDelegate
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    //ScreenImage
    func getScreenImage() -> UIImage? {
        var result: UIImage?
        self.toolView.hidden = true
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, UIScreen.mainScreen().scale)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.toolView.hidden = false
        return result
    }
    
    //UIActionSheetDelegate
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            WQPShare.shareCalendarByWeibo(self, image: self.screenImage!, text: "\(NSDate().getYMDStr()) \(self.textView.goodLabel.text!)")
        } else if buttonIndex == 1 {
            WQPShare.shareCalendarByWeChat(self, image: self.screenImage!)
        }
    }
    
    func actionSheetCancel(actionSheet: UIActionSheet) {
    }
}
