//
//  UserViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation


class UserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate {
    
    var dataArray = ["我的收藏","意见反馈","清除缓存","评论","地图工具","扫一扫"]
    
    lazy var tableview: UITableView = {
        let tv = UITableView.init(frame: CGRectMake(10, 94, SCREEN_W - 20, 480), style: UITableViewStyle.Plain)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .None
        self.view.addSubview(tv)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "bgImage.jpg")!)
        self.navigationItem.title = "个人设置"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "更多设置", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.moreSetting))
        self.tableview.reloadData()
    }
    
    func moreSetting(){
        
    }
    
    //MARK:----tableview的协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("user")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Value1, reuseIdentifier: "user")
            cell?.textLabel?.textColor = UIColor.blackColor()
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell?.textLabel?.font = UIFont.systemFontOfSize(20)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        let name = dataArray[indexPath.row]
        cell?.textLabel?.text = name
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let cvc = CollectViewController()
            cvc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(cvc, animated: true)
            
        }else if indexPath.row == 1 {
            if MFMailComposeViewController.canSendMail() {
                // 注意这个实例要写在 if block 里，否则无法发送邮件时会出现两次提示弹窗（一次是系统的）
                let mailComposeViewController = configuredMailComposeViewController()
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }

        } else if indexPath.row == 2 {
            self.clear()
        } else if indexPath.row == 3 {
            let url = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(LiangCangZangChunyu.appid)"
            UIApplication.sharedApplication().openURL(NSURL.init(string: url)!)
        } else if indexPath.row == 4 {
            let mvc = MapViewController()
            mvc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(mvc, animated: true)
        } else if indexPath.row == 5 {
            self.weixinStyle()
        }
        
    }
    
    func clear() -> Void {
        let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        //  print(cachePath)
        //取出文件夹下所有文件数组
        let files = NSFileManager.defaultManager().subpathsAtPath(cachePath!)
        var big = Int() //用于统计文件夹所有文件大小
        for p in files!{//快速枚举所有文件名
            //把文件名拼接到路径中
            let path = cachePath!.stringByAppendingFormat("/\(p)")
            //取出文件属性
            let folder = try! NSFileManager.defaultManager().attributesOfItemAtPath(path)
            for (abc,bcd) in folder{ //用元组取出文件属性大小
                if abc == NSFileSize{//只取出文件大小进行拼接
                    big += bcd.integerValue
                }
            }
        }
        let  message = "\(big/(1024*1024))M缓存"
        let alter = UIAlertController.init(title: "清除缓存吗?", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            for p in files!{ //点击确定是删除
                let path = cachePath!.stringByAppendingFormat("/\(p)")
                if (NSFileManager.defaultManager().fileExistsAtPath(path)){
                    do{ //防止异常崩溃
                        try NSFileManager.defaultManager().removeItemAtPath(path)
                    }catch{
                        
                    }
                }
            }
        }
        alter.addAction(action)
        let cancle = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel) { (cancle) in
        }
        alter.addAction(cancle)
        self.navigationController?.presentViewController(alter, animated: true, completion: nil)
    }
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        // 设置邮件地址、主题及正文
        mailComposeVC.setToRecipients(["< 1161593263@qq.com >"])
        mailComposeVC.setSubject("< 邮件主题 >")
        mailComposeVC.setMessageBody("< 邮件正文 >", isHTML: false)
        
        return mailComposeVC
        
    }
    
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "无法发送邮件", message: "您的设备尚未设置邮箱，请在“邮件”应用中设置后再尝试发送。", preferredStyle: .Alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .Default) { _ in })
        self.presentViewController(sendMailErrorAlert, animated: true){}
        
    }

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("取消发送")
        case MFMailComposeResultSent.rawValue:
            print("发送成功")
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //二维码扫描
    func weixinStyle(){
        //设置扫码区域参数
        var style = LBXScanViewStyle()
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        style.photoframeLineW = 2;
        style.photoframeAngleW = 18;
        style.photoframeAngleH = 18;
        style.isNeedShowRetangle = false;
        
        style.anmiationStyle = LBXScanViewAnimationStyle.LineMove;
        
        style.colorAngle = UIColor(red: 0.0/255, green: 200.0/255.0, blue: 20.0/255.0, alpha: 1.0)
        
        
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_Scan_weixin_Line")
        
        
        let vc = LBXScanViewController();
        vc.scanStyle = style
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
