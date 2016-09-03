//
//  SpecialView.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

/**商店-专题*/
class SpecialView: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    weak var delegate:ShopDelegate?
    var page: NSInteger = 1
    var dataArray = NSMutableArray()
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        let cv = UICollectionView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H - 108 - 49), collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.registerNib(UINib.init(nibName: "SpeciallCell", bundle: nil), forCellWithReuseIdentifier: "SpeciallCell")
        self.contentView.addSubview(cv)
        cv.footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { 
            self.page += 1
            self.loadSpecialData()
        })
        return cv
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
                self.collectionView.footer.endRefreshing()
                self.collectionView.reloadData()
            }
            HDManager.stopLoading()
        }
    }
    
    
    //MARK:---collectionview的协议方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SpeciallCell", forIndexPath: indexPath) as! SpeciallCell
        let model = dataArray[indexPath.row] as! SpecialModel
        cell.backImage.sd_setImageWithURL(NSURL.init(string: model.cover_img_new))
        cell.detailLabel.text = model.topic_name
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let sdvc = ShopDetailViewController()
        sdvc.hidesBottomBarWhenPushed = true
        let model = dataArray[indexPath.row] as! SpecialModel
        sdvc.model = model
        self.delegate?.pushToViewController(sdvc)
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(SCREEN_W, 200)
    }
}