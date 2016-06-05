//
//  HistoryCell.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit

class HistoryCell: UICollectionViewCell {
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: WQPPhoto.thumbSize))
        self.imageView.backgroundColor = UIColor.whiteColor()
        self.imageView.contentMode = .ScaleAspectFit
        self.contentView.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
