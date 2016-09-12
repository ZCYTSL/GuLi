//
//  GoodsDetailViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import CoreLocation

protocol GoodsDetailDelegate: class {
    func pushToViewController()->Void
    
}

class GoodsDetailViewController: UIViewController,UMSocialUIDelegate,UITableViewDelegate,UITableViewDataSource,GoodsDetailDelegate {

    var goodId = ""
    var page :NSInteger = 1
    var nameStr: String!
    var urlStr: String!
    var imageUrl: String!
    var priceUrl: String!
    
    var commentArray = NSMutableArray()
    lazy var tableView:UITableView = {
        let tv = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64), style: UITableViewStyle.Plain)
        tv.backgroundColor = UIColor.blackColor()
        tv.rowHeight = UITableViewAutomaticDimension
        tv.estimatedRowHeight = 400
        self.view.addSubview(tv)
        tv.delegate = self
        tv.dataSource = self
        tv.tableHeaderView = self.headView
        tv.separatorStyle = .None
        tv.registerClass(CommenCell.self, forCellReuseIdentifier: "CommenCell")
        return tv
    }()
    
    lazy var headView:HeadView = {
        let hv = HeadView.init(frame: CGRectMake(0, 0, SCREEN_W, 400))
        hv.delegate = self
//        hv.sss = self.urlStr
        return hv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.loadData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "分享", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.shareButton(_:)))
        self.navigationItem.title = "良品"
        
    }
    
    //分享到微信和QQ
    func shareButton(button: UIButton) -> Void {

        UMSocialData.defaultData().extConfig.wechatSessionData.url = self.urlStr
        UMSocialData.defaultData().extConfig.wechatSessionData.title = self.nameStr
        UMSocialData.defaultData().extConfig.wechatTimelineData.title = self.nameStr
        UMSocialData.defaultData().extConfig.wechatTimelineData.url = self.urlStr
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: AppKey, shareText: "良仓", shareImage: UIImage.init(named: "bgImage.jpg"), shareToSnsNames: [UMShareToWechatSession,UMShareToWechatTimeline], delegate: self)
    }
    
    //分享的回调
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        
        if response.responseCode == UMSResponseCodeSuccess{
            print("分享成功")
        }else if response.responseCode == UMSResponseCodeCancel{
            print("用户取消分享")
        }else{
            print("分享失败")
        }
    }
    
    //获取数据
    func loadData() -> Void {
        HDManager.startLoading()
        GoodsModel.requestGoodsData(self.goodId) { (s1, s2, s3, s4, error) in
            if error == nil {
                self.nameStr = s1
                self.urlStr = s2
                self.imageUrl = s3
                self.priceUrl = s4
                
                self.headView.backImage.sd_setImageWithURL(NSURL.init(string: self.imageUrl))
                self.headView.nameLabel.text = self.nameStr
                self.headView.priceLabel.text = "￥" + self.priceUrl
                self.tableView.reloadData()
            }
            HDManager.stopLoading()
        }
        CommentModel.requestData(self.page, goodsId: self.goodId) { (array, error) in
            if error == nil {
                self.commentArray.addObjectsFromArray(array!)
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK:---tableview的协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommenCell", forIndexPath: indexPath) as! CommenCell
        cell.backgroundColor = UIColor.blackColor()
        cell.selectionStyle = .None
        let model = self.commentArray[indexPath.row] as! CommentModel
        cell.iconImage.sd_setImageWithURL(NSURL.init(string: model.userImage))
        cell.nameLabel.text = model.userName + ":"
        cell.detailLabel.text = model.msg
        cell.timeLabel.text = model.createTime
        return cell
    }
    
    //MARK:---GoodsDetailDelegate协议方法
    func pushToViewController() {
       let vc = GoodsViewController()
        vc.urlStr = self.urlStr
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
