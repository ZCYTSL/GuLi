//
//  SpecialView.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

/**商店-专题*/
class SpecialView: UICollectionViewCell,UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate:ShopDelegate?
    var page: NSInteger = 1
    var dataArray = NSMutableArray()
    lazy var tableView: UITableView = {
        let tv = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - 108 - 49), style: .Plain)
        tv.delegate = self
        tv.dataSource = self
        self.contentView.addSubview(tv)
        tv.registerNib(UINib.init(nibName: "SpecialViewCell", bundle: nil), forCellReuseIdentifier: "SpecialViewCell")
        tv.footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { 
            self.page += 1
            self.loadSpecialData()
        })
        return tv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadSpecialData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSpecialData() -> Void {
        HDManager.startLoading()
        SpecialModel.requestSpecialData(self.page) { (array, error) in
            if error == nil {
                self.dataArray.addObjectsFromArray(array!)
                self.tableView.footer.endRefreshing()
                self.tableView.reloadData()
            }
            HDManager.stopLoading()
        }
    }
    
    //MARK:---tableview 的协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SpecialViewCell", forIndexPath: indexPath) as! SpecialViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let model = dataArray[indexPath.row] as! SpecialModel
        cell.backImage.sd_setImageWithURL(NSURL.init(string: model.cover_img_new))
        cell.ditailLabel.text = model.topic_name
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sdvc = ShopDetailViewController()
        sdvc.hidesBottomBarWhenPushed = true
        let model = dataArray[indexPath.row] as! SpecialModel
        sdvc.model = model
        self.delegate?.pushToViewController(sdvc)
        
    }
}