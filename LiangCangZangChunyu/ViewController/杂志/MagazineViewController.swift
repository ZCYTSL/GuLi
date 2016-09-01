//
//  MagazineViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MagazineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var sectionArray = NSMutableArray()
    var dataArray = NSMutableArray()
    
    
    lazy var tableView: UITableView = {
        let tv = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49), style: .Grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .None
        self.view.addSubview(tv)
        tv.registerNib(UINib.init(nibName: "MagazineCell", bundle: nil), forCellReuseIdentifier: "MagazineCell")
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "杂志"
        self.automaticallyAdjustsScrollViewInsets = false
        self.loadMagazineData()
       
    }
//MARK:----获取数据
    func loadMagazineData() -> Void {
        HDManager.startLoading()
        MagazineModel.requestData { (array1,array2,error) in
            if error == nil {
                self.sectionArray.addObjectsFromArray(array1!)
                self.dataArray.addObjectsFromArray(array2!)
                self.tableView.reloadData()
            }
            HDManager.stopLoading()
        }
    }
//MARK:---tableview的协议方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataArray.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = sectionArray[section] as! [AnyObject]
        return array.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MagazineCell", forIndexPath: indexPath) as! MagazineCell
        let section = sectionArray[indexPath.section] as! [MagazineModel]
        let model = section[indexPath.row]
        cell.backImage.sd_setImageWithURL(NSURL.init(string: model.cover_img))
        cell.detailLabel.text = model.topic_name
        cell.littelLabel.text = model.cat_name
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 210
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, 40))
        view.backgroundColor = UIColor.blackColor()
        let label = UILabel.init(frame: CGRectMake(0, 10, SCREEN_W, 20))
        var string = ""
        for str in dataArray {
            string = str as! String
        }
        
        label.text = string
        label.font = UIFont.systemFontOfSize(16)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        view.addSubview(label)
        return view
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dvc = DetailViewController()
        dvc.hidesBottomBarWhenPushed = true
        let section = sectionArray[indexPath.section] as! [MagazineModel]
        let model = section[indexPath.row]
        dvc.model = model
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    

}
