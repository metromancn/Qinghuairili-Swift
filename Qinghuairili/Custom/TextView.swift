//
//  TextView.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit

class TextView: UIView {
    var topSpace: Int!
    var bottomSpace: Int!
    
    var monthLabel: UILabel!
    var dateLabel: UILabel!
    var weekLabel: UILabel!
    var weatherLabel: UILabel!
    var goodLabel: UILabel!
    var badLabel: UILabel!
    var contentLabel: UILabel!
    var lineLabel: UILabel!
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: Template.getImageHeight(), width: Int(ScreenSize.SCREEN_WIDTH), height: Int(ScreenSize.SCREEN_HEIGHT) - Template.getImageHeight()))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        topSpace = Template.getTextTopSpace()
        bottomSpace = 49 + Template.getTextBottomSpace()
        addMonthLabel()
        addDateLabel()
        addWeekLabel()
        addWeatherLabel()
        addGoodLabel()
        addBadLabel()
        addContentLabel()
        addLineLabel()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func addMonthLabel() {
        monthLabel = UILabel(frame: CGRect(x: 0, y: topSpace, width: 48, height: 48))
        monthLabel.textAlignment = .Right
        monthLabel.font = UIFont.systemFontOfSize(17)
        monthLabel.textColor = UIColor.blackColor()
        monthLabel.text = "\(NSDate().getMonthValue()!)月"
        self.addSubview(monthLabel)
    }
    
    func addDateLabel() {
        dateLabel = UILabel(frame: CGRect(x: 52, y: topSpace, width: 100, height: 48))
        dateLabel.textAlignment = .Left
        dateLabel.font = UIFont.systemFontOfSize(59)
        dateLabel.textColor = UIColor.blackColor()
        dateLabel.text = "\(NSDate().getDayValue()!)"
        self.addSubview(dateLabel)
    }
    
    func addWeekLabel() {
        weekLabel = UILabel(frame: CGRect(x: Int(frame.width) - 100, y: topSpace, width: 100, height: 28))
        weekLabel.textAlignment = .Center
        weekLabel.font = UIFont.systemFontOfSize(17)
        weekLabel.textColor = UIColor.blackColor()
        weekLabel.text = NSDate().getWeekStr()
        self.addSubview(weekLabel)
    }
    
    func addWeatherLabel() {
        weatherLabel = UILabel(frame: CGRect(x: Int(frame.width) - 100, y: topSpace + Int(weekLabel.frame.height), width: 100, height: 20))
        weatherLabel.textAlignment = .Center
        weatherLabel.font = UIFont.systemFontOfSize(14)
        weatherLabel.textColor = UIColor.blackColor()
        weatherLabel.text = WeatherType.getWeatherStr(.Sunny)
        self.addSubview(weatherLabel)
    }
    
    func addGoodLabel() {
        goodLabel = UILabel(frame: CGRect(x: 20, y: Int(frame.height) - bottomSpace - 20, width: Int(frame.width / 2) - 30, height: 20))
        goodLabel.textAlignment = .Center
        goodLabel.font = UIFont.STFangsong(14)
        goodLabel.textColor = UIColor.blackColor()
        goodLabel.text = Demo.getGood()
        self.addSubview(goodLabel)
    }
    
    func addBadLabel() {
        badLabel = UILabel(frame: CGRect(x: Int(frame.width / 2) + 10, y: Int(frame.height) - bottomSpace - 20, width: Int(frame.width / 2) - 30, height: 20))
        badLabel.textAlignment = .Center
        badLabel.font = UIFont.STFangsong(14)
        badLabel.textColor = UIColor.blackColor()
        badLabel.text = Demo.getBad()
        self.addSubview(badLabel)
    }
    
    func addContentLabel() {
        let monthBottom = Int(monthLabel.frame.origin.y + monthLabel.frame.height)
        let goodTop = Int(goodLabel.frame.origin.y)
        contentLabel = UILabel(frame: CGRect(x: 40, y: monthBottom, width: Int(frame.width) - 80, height: goodTop - monthBottom - 20))
        contentLabel.textAlignment = .Center
        contentLabel.font = UIFont.STFangsong(17)
        contentLabel.textColor = UIColor.blackColor()
        contentLabel.numberOfLines = 10
        contentLabel.text = Demo.getContent()
        self.addSubview(contentLabel)
    }
    
    func addLineLabel() {
        lineLabel = UILabel(frame: CGRect(x: 20, y: Int(frame.height) - bottomSpace - 2, width: Int(frame.width) - 40, height: 1))
        lineLabel.backgroundColor = UIColor.fromRGB(144, 144, 144)
        self.addSubview(lineLabel)
    }
}
