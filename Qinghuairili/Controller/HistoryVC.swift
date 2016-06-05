//
//  HistoryVC.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit
import Photos

class HistoryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var collectionVC: UICollectionView!
    let HistoryCellID = "HistoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = WQPHelper.getBackBar()
        self.navigationItem.title = "我的回忆"
        if WQPPhoto.sharedInstance.photoCount > 0 {
            //CollectionView
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = WQPPhoto.thumbSize
            self.collectionVC = UICollectionView(frame: CGRect(x: 0, y: 64, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT - 64), collectionViewLayout: layout)
            self.collectionVC.backgroundColor = UIColor.whiteColor()
            self.collectionVC.registerClass(HistoryCell.classForCoder(), forCellWithReuseIdentifier: HistoryCellID)
            self.collectionVC.dataSource = self
            self.collectionVC.delegate = self
            self.view.addSubview(self.collectionVC)
        }
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
    
    //Delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WQPPhoto.sharedInstance.photoCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HistoryCellID, forIndexPath: indexPath) as! HistoryCell
        WQPPhoto.sharedInstance.fetchImage(cell.imageView, index: indexPath.row, isFullSize: false)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return WQPPhoto.thumbSize
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let imageVC = ImageVC(nibName: "ImageVC", bundle: nil)
        imageVC.index = indexPath.row
        self.navigationController?.pushViewController(imageVC, animated: true)
    }
}
