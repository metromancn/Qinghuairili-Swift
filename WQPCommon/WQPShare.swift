//
//  WQPShare.swift
//  Qinghuairili
//
//  Created by WUQIUPING on 2016/05/01.
//  Copyright © 2016年 MetroMan. All rights reserved.
//

import UIKit
class WQPShare {
    static var shareVC: UIViewController!
    
    static func initShareSDK() {
        ShareSDK.registerApp("1260081980794",
                             activePlatforms: [SSDKPlatformType.TypeSinaWeibo.rawValue, SSDKPlatformType.TypeWechat.rawValue],
                             onImport: {(platform: SSDKPlatformType) -> Void in
                                switch platform {
                                case .TypeSinaWeibo:
                                    ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                                case .TypeWechat:
                                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                                default:
                                    break;
                                }
            },
                             onConfiguration: {(platform: SSDKPlatformType, appInfo: NSMutableDictionary!) -> Void in
                                switch platform {
                                case .TypeSinaWeibo:
                                    appInfo.SSDKSetupSinaWeiboByAppKey("241824568", appSecret: "b5c3a7cd0866f42f2c7990ca0fcf03de", redirectUri: "http://www.metroman.cn", authType: SSDKAuthTypeBoth)
                                case .TypeWechat:
                                    appInfo.SSDKSetupWeChatByAppId("wx0dbf9ec1abb5471d", appSecret: "e89bf2928e3cb2e43f2f94ca77c292c1")
                                default:
                                    break;
                                }
            }
        )
    }
    
    static func showShareActionSheet(title: String, vc: UIActionSheetDelegate, view: UIView) {
        let shareSheet = UIActionSheet()
        shareSheet.delegate = vc
        shareSheet.title = title
        shareSheet.addButtonWithTitle("新浪微博")
        shareSheet.addButtonWithTitle("微信朋友圈")
        shareSheet.addButtonWithTitle("取消")
        shareSheet.cancelButtonIndex = 2
        shareSheet.showInView(view)
    }
    
    static func shareAppByWeibo(vc: UIViewController) {
        self.shareVC = vc
        let shareParams = NSMutableDictionary()
        //itms-apps://itunes.apple.com/app/id1109727871
        //https://itunes.apple.com/app/id1109727871
        shareParams.SSDKSetupSinaWeiboShareParamsByText("@情怀日历 挑选一张中意的图片，配上二两情怀，自行选择宜和忌，制作一张属于你自己的个性老黄历。App Store搜索\"情怀日历\"下载App。 https://itunes.apple.com/app/id1109727871", title: "", image: UIImage(named: "img_share.png"), url: nil, latitude: 0, longitude: 0, objectID: nil, type: SSDKContentType.Image)
        ShareSDK.share(.TypeSinaWeibo, parameters: shareParams, onStateChanged: shareChangedHandler)
    }
    
    static func shareAppByWeChat(vc: UIViewController) {
        self.shareVC = vc
        let shareParams = NSMutableDictionary()
        shareParams.SSDKSetupWeChatParamsByText("", title: "", url: nil, thumbImage: nil, image: UIImage(named: "img_share.png"), musicFileURL: nil, extInfo: nil, fileData: nil, emoticonData: nil, type: .Image, forPlatformSubType: .SubTypeWechatTimeline)
        ShareSDK.share(.SubTypeWechatTimeline, parameters: shareParams, onStateChanged: shareChangedHandler)
    }
    
    static func shareCalendarByWeibo(vc: UIViewController, image: UIImage, text: String) {
        self.shareVC = vc
        let shareParams = NSMutableDictionary()
        shareParams.SSDKSetupSinaWeiboShareParamsByText("\(text) - 来自@情怀日历 App Store搜索\"情怀日历\"有惊喜。 https://itunes.apple.com/app/id1109727871", title: "", image: image, url: nil, latitude: 0, longitude: 0, objectID: nil, type: SSDKContentType.Image)
        ShareSDK.share(.TypeSinaWeibo, parameters: shareParams, onStateChanged: shareChangedHandler)
    }
    
    static func shareCalendarByWeChat(vc: UIViewController, image: UIImage) {
        self.shareVC = vc
        let shareParams = NSMutableDictionary()
        shareParams.SSDKSetupWeChatParamsByText("", title: "", url: nil, thumbImage: nil, image: image, musicFileURL: nil, extInfo: nil, fileData: nil, emoticonData: nil, type: .Image, forPlatformSubType: .SubTypeWechatTimeline)
        ShareSDK.share(.SubTypeWechatTimeline, parameters: shareParams, onStateChanged: shareChangedHandler)
    }
    
    static func shareChangedHandler(state: SSDKResponseState, userData: [NSObject: AnyObject]!, contentEntity: SSDKContentEntity!, error: NSError!) {
        switch state {
        case .Success:
            shareVC.toast("分享成功！", duration: 0.5)
        case .Fail:
            shareVC.toast("分享失败！错误描述：\(error)", duration: 0.5)
        case .Cancel:
            break
        default:
            break
        }
    }
}
