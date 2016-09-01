//
//  GoodsDetailViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import CoreLocation
class GoodsDetailViewController: UIViewController, UMSocialUIDelegate {

    var goodId = ""
    var page :NSInteger = 1
    var nameStr: String!
    var urlStr: String!
    var imageUrl: String!
    var priceUrl: String!
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "分享", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.shareButton(_:)))
        self.navigationItem.title = "良品"
        
    }
    
    func shareButton(button: UIButton) -> Void {
        //分享到微信好友
        UMSocialData.defaultData().extConfig.wechatSessionData.url = self.urlStr
        UMSocialData.defaultData().extConfig.wechatSessionData.title = self.nameStr
        
        // 分享到微信朋友圈
        UMSocialData.defaultData().extConfig.wechatTimelineData.title = self.nameStr
        UMSocialData.defaultData().extConfig.wechatTimelineData.url = self.urlStr
    
        print(urlStr)
        //弹出分享视图
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: AppKey, shareText: "良仓", shareImage: UIImage.init(named: ""), shareToSnsNames: [UMShareToWechatSession,UMShareToWechatTimeline], delegate: self)

        
        
    }
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        
        if response.responseCode == UMSResponseCodeSuccess{
//            print("分享成功")
        }else if response.responseCode == UMSResponseCodeCancel{
//            print("用户取消分享")
        }else{
//            print("分享失败")
        }
    }

    
    func loadData() -> Void {
        HDManager.startLoading()
        GoodsModel.requestGoodsData(self.goodId) { (s1, s2, s3, s4, error) in
            if error == nil {
                self.nameStr = s1
                self.urlStr = s2
                self.imageUrl = s3
                self.priceUrl = s4
                
                self.backImage.sd_setImageWithURL(NSURL.init(string: self.imageUrl))
                self.nameLabel.text = self.nameStr
                self.priceLabel.text = "￥" + self.priceUrl
            }
            HDManager.stopLoading()
        }
        
    }
    @IBAction func webButton(sender: UIButton) {
        let gvc = GoodsViewController()
        gvc.hidesBottomBarWhenPushed = true
        gvc.urlStr = urlStr
        self.navigationController?.pushViewController(gvc, animated: true)
    }



}
