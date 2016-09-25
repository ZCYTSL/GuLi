//
//  GoodsDetailViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import CoreLocation
import SDWebImage

class GoodsDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HeadViewDelegate {

    var goodId = ""
    var page :NSInteger = 1
    var nameStr: String!
    var urlStr: String!
    var imageUrl: String!
    var priceUrl: String!
    var uid: Int?
    var model:RecommendedModel!
    var isCollect:Bool!
    
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
        return hv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.loadData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "分享", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.shareButton(_:)))
        self.navigationItem.title = "良品"
        
    }
    func shareButton(button: UIButton) -> Void {
        var shareParames = NSMutableDictionary()
        shareParames.SSDKSetupShareParamsByText("分享内容", images: UIImage.init(named: "1.jpg"), url: NSURL.init(string: "https://www.baidu.com"), title: "分享标题", type: SSDKContentType.Auto)
        
        ShareSDK.showShareActionSheet(view, items: [SSDKPlatformType.TypeWechat.rawValue], shareParams: shareParames) { (state, platformType, userdata, contentEnity, error, end) in
            switch state {
            case SSDKResponseState.Success:
                print("分享成功")
            case SSDKResponseState.Fail:
                print("分享失败")
            case SSDKResponseState.Cancel:
                print("取消分享")
            default:
                break
            }
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
    
    func click() {

        if model == nil {
            model = RecommendedModel()
        }
        let Arr = DataManager.defaultManager.selectAll()
        if Arr.contains(model) {
            DataManager.defaultManager.remove(model!)
            DataManager.defaultManager.insertWith(model!)
        } else {
            DataManager.defaultManager.insertWith(model!)
        }
    }
    
    
}
