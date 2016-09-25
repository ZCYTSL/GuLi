//
//  CollectViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CollectViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var tableView:UITableView = {
        let tv = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64), style: .Plain)
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = UIColor.blackColor()
        tv.separatorStyle = .None
        self.view.addSubview(tv)
        return tv
    }()
    var dataArray = [RecommendedModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        dataArray = DataManager.defaultManager.selectAll()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    //MARK:----tableview的协议方法

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
            cell?.backgroundColor = UIColor.blackColor()
            cell?.contentView.backgroundColor = UIColor.blackColor()
            cell?.textLabel?.textColor = UIColor.whiteColor()
            cell?.detailTextLabel?.textColor = UIColor.whiteColor()
            cell?.selectionStyle = .None
        }
        let model = dataArray[indexPath.row]
        cell?.textLabel?.text = model.goods_name
        cell?.detailTextLabel?.text = model.price
        cell?.imageView?.sd_setImageWithURL(NSURL.init(string: model.goods_image))
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    
    func tableView(tableView:UITableView, editingStyleForRowAtIndexPath indexPath:NSIndexPath)->UITableViewCellEditingStyle {
        return .Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == .Delete {
            let model = self.dataArray[indexPath.row]
            DataManager.defaultManager.remove(model)
            dataArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath],withRowAnimation:.Right)
    }
}
    
  
    
    
    


}
