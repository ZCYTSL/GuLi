//
//  BrandView.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import MJRefresh

/**商店-品牌*/
class BrandView: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
    
    weak var delegate:ShopDelegate?
    var page: NSInteger = 1
    var dataArray = NSMutableArray()
    lazy var tableView: UITableView = {
        let tv = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - 108 - 49), style: .Plain)
        self.contentView.addSubview(tv)
        tv.delegate = self
        tv.dataSource = self
        tv.bounces = false
        tv.separatorInset = UIEdgeInsetsZero
        tv.registerNib(UINib.init(nibName: "BrandViewCell", bundle: nil), forCellReuseIdentifier: "BrandViewCell")
        tv.mj_header = RefeshHeader.init(refreshingBlock: {
            self.page = 1
            self.loadBrandData()
        })
        tv.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 1
            self.loadBrandData()
        })
        return tv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadBrandData()
    }
    //MARK:---获取数据
    func loadBrandData() -> Void {
        HDManager.startLoading()
        BrandModel.requestBrandData(self.page) { (array, error) in
            if error == nil {
                if self.page == 1 {
                    self.dataArray.removeAllObjects()
                }
                self.dataArray.addObjectsFromArray(array!)
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
                self.tableView.mj_header.endRefreshing()
            }
            HDManager.stopLoading()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:--tableview的协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BrandViewCell", forIndexPath: indexPath) as! BrandViewCell
        cell.selectionStyle = .None
        cell.contentView.backgroundColor = UIColor.init(red: 0.6, green: 0.9, blue: 0.6, alpha: 0.5)
        let model = self.dataArray[indexPath.row] as! BrandModel
        cell.brandLabel.text = model.brand_name
        cell.brandImageView.sd_setImageWithURL(NSURL.init(string: model.brand_logo))
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let blvc = BrandListViewController()
        let model = self.dataArray[indexPath.row] as! BrandModel
        blvc.brand_name = model.brand_name
        blvc.brand_logo = model.brand_logo
        blvc.brand_id = model.brand_id
        blvc.hidesBottomBarWhenPushed = true
        self.delegate?.pushToViewController(blvc)
    }
    
    
    
    
    
    
    
    
}