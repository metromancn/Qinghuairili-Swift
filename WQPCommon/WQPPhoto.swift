//
//  WQPPhotoAlbum.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import Photos

class WQPPhoto: NSObject {
    static let albumName = "情怀日历"
    static let errMsg = "照片被禁用，请在设置－隐私－照片中开启"
    static let sharedInstance = WQPPhoto()
    static let fullSize = CGSize(width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
    static let thumbSize = CGSize(width: ScreenSize.SCREEN_WIDTH / 3, height: ScreenSize.SCREEN_HEIGHT / 3)
    
    var album: PHAssetCollection?
    var photos: PHFetchResult?
    var photoCount = 0
    
    func initAlbum() {
        if self.album == nil {
            if let album = self.fetchAlbum() {
                self.album = album
            } else {
                self.createAlbum()
            }
        }
    }
    
    func refreshPhotos() {
        if self.album != nil {
            let fetchOption = PHFetchOptions()
            fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            self.photos = PHAsset.fetchAssetsInAssetCollection(self.album!, options: fetchOption)
            self.photoCount = self.photos!.count
        }
    }
    
    func saveImage(image: UIImage, completionHandler: ((Bool, NSError?) -> Void)?) {
        if self.album != nil {
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
                let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
                let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.album!)
                albumChangeRequest!.addAssets([assetPlaceHolder!])
                }, completionHandler: completionHandler)
        }
    }
    
    func createAlbum() {
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(WQPPhoto.albumName)
        }) { success, error in
            if success {
                self.album = self.fetchAlbum()
            } else {
                print("createAlbum_error: \(error)")
            }
        }
    }
    
    func fetchAlbum() -> PHAssetCollection? {
        var result: PHAssetCollection? = nil
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", WQPPhoto.albumName)
        let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        if let _: AnyObject = collection.firstObject {
            result = collection.firstObject as? PHAssetCollection
        }
        return result
    }
    
    func fetchImage(imageView: UIImageView, index: Int, isFullSize: Bool) {
        if photoCount > index {
            let asset = self.photos![index] as! PHAsset
            let size = isFullSize ? WQPPhoto.fullSize : WQPPhoto.thumbSize
            PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: size, contentMode: .AspectFit, options: nil) {(image: UIImage?, info: [NSObject: AnyObject]?) -> Void in
                imageView.image = image!
            }
        }
    }
}
