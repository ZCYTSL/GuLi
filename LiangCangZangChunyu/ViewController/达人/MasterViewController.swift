//
//  MasterViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let cellWidth = (UIScreen.mainScreen().bounds.width - 20 - (3 + 1) * 8) / 3
    var page: NSInteger = 1
    var dataArray = NSMutableArray()
    var imageArray = NSMutableArray()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        let cv = UICollectionView.init(frame: CGRectMake(10, 74, SCREEN_W - 20, SCREEN_H - 49), collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        self.view.addSubview(cv)
        cv.registerNib(UINib.init(nibName: "MyCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        cv.header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.page = 1
            self.loadMasterData()
        })
        
        cv.footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 1
            self.loadMasterData()
        })
        
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "达人"
        self.loadMasterData()
    }

    //MARK:----获取数据
    func loadMasterData() -> Void {
        HDManager.startLoading()
        MasteModel.requestData(self.page) { (array,imageArray,error) in
            if error == nil {
                if self.page == 1 {
                    self.dataArray.removeAllObjects()
                    self.imageArray.removeAllObjects()
                }
                self.dataArray.addObjectsFromArray(array!)
                self.imageArray.addObjectsFromArray(imageArray!)
                self.collectionView.reloadData()

            }
            HDManager.stopLoading()
        }
        self.collectionView.header.endRefreshing()
        self.collectionView.footer.endRefreshing()
    }
    
    //MARK:----collectonview 的协议方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as! MyCell
        let image = imageArray[indexPath.item] as! ImageModel
        let model = dataArray[indexPath.item] as! MasteModel
        cell.iconImage.sd_setImageWithURL(NSURL.init(string: image.orig))
        cell.nameLabel.text = model.username
        cell.professionalLabel.text = model.duty
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(cellWidth, cellWidth*5/3)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let mdvc = MasterDetailViewController()
        mdvc.hidesBottomBarWhenPushed = true
        let model = dataArray[indexPath.item] as! MasteModel
        let image = imageArray[indexPath.item] as! ImageModel
        mdvc.model = model
        mdvc.usid = model.uid
        mdvc.image = image
        self.navigationController?.pushViewController(mdvc, animated: true)
        
    }
    



}
