//
//  MasterDetailViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import MJRefresh

class MasterDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var professionalLabel: UILabel!
    
    var page: NSInteger = 1
    var usid: String = ""
    var dataArray = NSMutableArray()
    var userArray = NSMutableArray()
    var imageArray = NSMutableArray()
    var fansArray = NSMutableArray()
    var fansImageArray = NSMutableArray()
    var image = ImageModel()
    var model = MasteModel()
    
    
    
    lazy var cv1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        let cv = UICollectionView.init(frame: CGRectMake(10, 84 + 180, SCREEN_W - 20, SCREEN_H - 84 - 49 - 180), collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        self.view.addSubview(cv)
        cv.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.page = 1
            self.loadData()
        })
        cv.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 1
            self.loadData()
        })
        cv.registerNib(UINib.init(nibName: "MasterCell", bundle: nil), forCellWithReuseIdentifier: "MasterCell")
        return cv
    }()
    lazy var cv2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        let cv = UICollectionView.init(frame: CGRectMake(10, 84 + 180, SCREEN_W - 20, SCREEN_H - 84 - 49 - 180), collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        self.view.addSubview(cv)
        cv.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.page = 1
            self.loadData()
        })
        cv.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 1
            self.loadData()
        })
        cv.registerNib(UINib.init(nibName: "MyCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        return cv
    }()
    lazy var cv3: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        let cv = UICollectionView.init(frame: CGRectMake(10, 84 + 180, SCREEN_W - 20, SCREEN_H - 84 - 49 - 180), collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        self.view.addSubview(cv)
        cv.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.page = 1
            self.loadData()
        })
        cv.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 1
            self.loadData()
        })
        cv.registerNib(UINib.init(nibName: "MyCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.iconImage.sd_setImageWithURL(NSURL.init(string: image.orig))
        self.nameLabel.text = model.username
        self.professionalLabel.text = model.duty
        self.loadData()
        self.navigationItem.title = model.username
        
    }
    //MARK:----获取数据
    func loadData() -> Void {
        HDManager.startLoading()
        RecommendedModel.requestData(self.page,usid: self.usid) { (array, error) in
            if error == nil {
                if self.page == 1 {
                    self.dataArray.removeAllObjects()
                }
                self.dataArray.addObjectsFromArray(array!)
                self.cv1.reloadData()
//                self.cv2.reloadData()
            }
            HDManager.stopLoading()
        }
        HDManager.startLoading()
        DetailsModel.requestUserData(self.page, usid: usid) { (array,imageArray,error) in
            if error == nil {
                if self.page == 1 {
                    self.userArray.removeAllObjects()
                }
                self.userArray.addObjectsFromArray(array!)
                self.imageArray.addObjectsFromArray(imageArray!)
                self.cv2.reloadData()
            }
            HDManager.stopLoading()
        }
        HDManager.startLoading()
        DetailsModel.requestFansData(self.page, usid: usid) { (array, imageArray, error) in
            if error == nil {
                if self.page == 1 {
                    self.fansArray.removeAllObjects()
                }
                self.fansArray.addObjectsFromArray(array!)
                self.fansImageArray.addObjectsFromArray(imageArray!)
                self.cv3.reloadData()
            }
            HDManager.stopLoading()
        }
        self.cv2.mj_header.endRefreshing()
        self.cv3.mj_header.endRefreshing()
        self.cv1.mj_header.endRefreshing()
        self.cv2.mj_footer.endRefreshing()
        self.cv3.mj_footer.endRefreshing()
        self.cv1.mj_footer.endRefreshing()
    }

    @IBAction func changeButton(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.view.bringSubviewToFront(cv1)
        } else if sender.selectedSegmentIndex == 1 {
            self.view.bringSubviewToFront(cv2)
        } else  {
            self.view.bringSubviewToFront(cv3)

        }
    }
    
    //MARK:----collectionView的协议方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cv1 {
            return dataArray.count
        } else if collectionView == cv2 {
            return userArray.count
        } else {
            return fansArray.count
        }
        
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == cv1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MasterCell", forIndexPath: indexPath) as! MasterCell
            let model = dataArray[indexPath.item] as! RecommendedModel
            cell.backImage.sd_setImageWithURL(NSURL.init(string: model.goods_image))
            return cell

        } else if collectionView == cv2 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as! MyCell
            let model = userArray[indexPath.item] as! UserModel
            let image = imageArray[indexPath.item] as! ImageModel
            cell.iconImage.sd_setImageWithURL(NSURL.init(string: image.orig))
            cell.nameLabel.text = model.user_name
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as! MyCell
            let model = fansArray[indexPath.item] as! UserModel
            let image = fansImageArray[indexPath.item] as! ImageModel
            cell.iconImage.sd_setImageWithURL(NSURL.init(string: image.orig))
            cell.nameLabel.text = model.user_name
            cell.professionalLabel.text = model.user_desc
            return cell

        }
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if collectionView == cv1 {
            let cellWidth = (UIScreen.mainScreen().bounds.width - 20 - 2 * 8) / 2
            return CGSizeMake(cellWidth, cellWidth)
        } else if collectionView == cv2 {
            let cellWidth = (UIScreen.mainScreen().bounds.width - 20 - 3 * 8) / 3
            return CGSizeMake(cellWidth, cellWidth * 1.3)
        } else {
            let cellWidth = (UIScreen.mainScreen().bounds.width - 20 - (2 + 1) * 8) / 3
            return CGSizeMake(cellWidth, cellWidth * 1.3)
        }
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == cv1 {
            let gdvc = GoodsDetailViewController()
            gdvc.hidesBottomBarWhenPushed = true
            let model = dataArray[indexPath.item] as! RecommendedModel
            gdvc.goodId = model.goods_id
            gdvc.model = model
//            print(model.goods_id)
            self.navigationController?.pushViewController(gdvc, animated: true)
        }
    }
    


}
