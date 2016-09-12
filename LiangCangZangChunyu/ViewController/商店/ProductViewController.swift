//
//  ProductViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/9/6.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    var goodID:String!
    var model:BrandListModel!
    var imageArray = NSMutableArray()
    lazy var headerView: XTADScrollView = {
        let hv = XTADScrollView.init(frame: CGRectMake(0, 0, SCREEN_W, 350))
        hv.infiniteLoop = true
        hv.needPageControl = true
        self.view.addSubview(hv)
        return hv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.loadData()
        
        
    }
    
    func loadData() {
        BrandListModel.requestProductData(self.goodID) { (array, error) in
            if error == nil {
                self.imageArray.addObjectsFromArray(array!)
                self.headerView.imageURLArray = self.imageArray as [AnyObject]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
