//
//  InputVC.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit

class InputVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var contentView: KMPlaceholderTextView!
    @IBOutlet weak var goodText: UITextField!
    @IBOutlet weak var badText: UITextField!
    @IBOutlet weak var weatherSegment: UISegmentedControl!
    
    var calendarVC: CalendarVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = WQPHelper.getBackBar()
        self.navigationItem.title = "内容编辑"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Done, target: self, action: #selector(InputVC.buttonAction(_:)))
        //Content
        self.contentView.placeholder = Demo.getContent()
        let contentStr = self.calendarVC.textView.contentLabel.text
        if contentStr != self.contentView.placeholder {
            self.contentView.text = contentStr
        }
        //Good
        self.goodText.delegate = self
        self.goodText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.goodText.frame.height))
        self.goodText.leftViewMode = UITextFieldViewMode.Always
        self.goodText.placeholder = Demo.getGood()
        let goodStr = self.calendarVC.textView.goodLabel.text!
        if goodStr != self.goodText.placeholder {
            self.goodText.text = goodStr.substringFromIndex(goodStr.startIndex.advancedBy(4))
        }
        //Bad
        self.badText.delegate = self
        self.badText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.goodText.frame.height))
        self.badText.leftViewMode = UITextFieldViewMode.Always
        self.badText.placeholder = Demo.getBad()
        let badStr = self.calendarVC.textView.badLabel.text!
        if badStr != self.badText.placeholder {
            self.badText.text = badStr.substringFromIndex(badStr.startIndex.advancedBy(4))
        }
        //Weather
        let weatherText = self.calendarVC.textView.weatherLabel.text
        self.weatherSegment.selectedSegmentIndex = WeatherType.getWeatherIndex(weatherText!)
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func buttonAction(sender: AnyObject) {
        calendarVC.needSaveAlert = true
        //Content
        let contentStr = contentView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        calendarVC.textView.contentLabel.text = contentStr.isEmpty ? contentView.placeholder : contentStr
        //Good
        var goodStr = goodText.text!.trim()
        while goodStr.hasPrefix(Demo.GOOD_PRE) {
            goodStr = goodStr.substringFromIndex(goodStr.startIndex.advancedBy(4)).trim()
        }
        calendarVC.textView.goodLabel.text = goodStr.isEmpty ? goodText.placeholder : "\(Demo.GOOD_PRE)\(goodStr)"
        //Bad
        var badStr = badText.text!.trim()
        while badStr.hasPrefix(Demo.BAD_PRE) {
            badStr = badStr.substringFromIndex(badStr.startIndex.advancedBy(4)).trim()
        }
        calendarVC.textView.badLabel.text = badStr.isEmpty ? badText.placeholder : "\(Demo.BAD_PRE)\(badStr)"
        //Weather
        calendarVC.textView.weatherLabel.text = WeatherType.getWeatherStr(WeatherType.allValues[self.weatherSegment.selectedSegmentIndex])
        //Close
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
