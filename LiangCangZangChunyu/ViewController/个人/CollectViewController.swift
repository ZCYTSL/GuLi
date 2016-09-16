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
        tv.rowHeight = 100
        self.view.addSubview(tv)
        return tv
    }()
    var dataArray = [RecommendedModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = DataManager.defaultManager.selectAll()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    func addModel(model: RecommendedModel) {
        dataArray.append(model)
        
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
            cell = UITableViewCell.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        }
        let model = dataArray[indexPath.row]
        cell?.textLabel?.text = model.goods_name
        cell?.imageView?.image = UIImage.init(named: model.goods_image)
        
        return cell!
    }
    


}
