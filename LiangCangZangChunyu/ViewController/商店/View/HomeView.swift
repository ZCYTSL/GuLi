//
//  HomeView.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import SDWebImage

/**商店-首页*/
class HomeView: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource  {
    
    lazy var tableView: UITableView = {
        let tv = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64 - 49), style: UITableViewStyle.Plain)
        tv.delegate = self
        tv.dataSource = self
        tv.tableHeaderView = self.headerView
        tv.registerNib(UINib.init(nibName: "OneViewCell", bundle: nil), forCellReuseIdentifier: "OneViewCell")
        tv.registerNib(UINib.init(nibName: "TwoViewCell", bundle: nil), forCellReuseIdentifier: "TwoViewCell")
        tv.registerNib(UINib.init(nibName: "ThreeViewCell", bundle: nil), forCellReuseIdentifier: "ThreeViewCell")
        self.contentView.addSubview(tv)
        return tv
        
    }()
    lazy var headerView: XTADScrollView = {
        let hv = XTADScrollView.init(frame: CGRectMake(0, 0, SCREEN_W, 250))
        hv.infiniteLoop = true
        hv.needPageControl = true
        return hv
    }()
    
    var sliderArray = NSMutableArray()
    var listArray = NSMutableArray()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadShopData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:---获取slider的数据
    func loadShopData() -> Void {
        HDManager.startLoading()
        SliderModel.requestShopData { (imageArray,array,error) in
            if error == nil {
                self.sliderArray.addObjectsFromArray(imageArray!)
                self.headerView.imageURLArray = self.sliderArray as [AnyObject]
                self.listArray.addObjectsFromArray(array!)
//                print(self.listArray)
                self.tableView.reloadData()
            }
            HDManager.stopLoading()
        }
    }
   

    //MARK:--tableView的协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("OneViewCell", forIndexPath: indexPath) as! OneViewCell
            let aa = listArray[0] as! listModel
            cell.oneImage.sd_setImageWithURL(NSURL.init(string: aa.pic_url))
            let bb = listArray[1] as! listModel
            cell.twoImage.sd_setImageWithURL(NSURL.init(string: bb.pic_url))
            let cc = listArray[2] as! listModel
            cell.threeImage.sd_setImageWithURL(NSURL.init(string: cc.pic_url))
            let dd = listArray[3] as! listModel
            cell.fourImage.sd_setImageWithURL(NSURL.init(string: dd.pic_url))
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("TwoViewCell", forIndexPath: indexPath) as! TwoViewCell
            let ee = listArray[4] as! listModel
            cell.backImage.sd_setImageWithURL(NSURL.init(string: ee.pic_url))
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ThreeViewCell", forIndexPath: indexPath) as! ThreeViewCell
            let ff = listArray[5] as! listModel
            cell.oneImage.sd_setImageWithURL(NSURL.init(string: ff.pic_url))
            let gg = listArray[6] as! listModel
            cell.twoImage.sd_setImageWithURL(NSURL.init(string: gg.pic_url))
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 400
        } else if indexPath.row == 1 {
            return 200
        } else {
            return 200
        }
    }

}

