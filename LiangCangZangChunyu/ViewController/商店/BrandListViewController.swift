//
//  BrandListViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class BrandListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var brand_name: String!
    var brand_logo: String!
    var brand_desc: String!
    var brand_id: NSNumber!
    var oneView: UIView!
    var dataArray = NSMutableArray()
    var brandLabel: UILabel!
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        let cv = UICollectionView.init(frame: CGRectMake(10, 274, SCREEN_W - 20, SCREEN_H - 274), collectionViewLayout: layout)
        cv.registerNib(UINib.init(nibName: "BrandListCell", bundle: nil), forCellWithReuseIdentifier: "BrandListCell")
        cv.delegate = self
        cv.dataSource = self
        self.view.addSubview(cv)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        nameLabel.text = self.brand_name
        iconImage.sd_setImageWithURL(NSURL.init(string: self.brand_logo))
        iconImage.layer.cornerRadius = iconImage.frame.size.height / 2
        iconImage.layer.masksToBounds = true
        oneView = UIView.init(frame: CGRectMake(10, 314, SCREEN_W - 20, SCREEN_H - 414))
        self.view.addSubview(oneView)
   
    }
    //MARK:----获取数据
    func loadData() -> Void {
        BrandListModel.requestBrandListData(self.brand_id){ (array, error) in
            if error == nil {
                self.dataArray.addObjectsFromArray(array!)
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK:--- collectionView 的协议方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BrandListCell", forIndexPath: indexPath) as! BrandListCell
        let model = dataArray[indexPath.item] as! BrandListModel
        cell.iconImge.sd_setImageWithURL(NSURL.init(string: model.goods_image))
        cell.nameLabel.text = model.goods_name
        cell.priceLabel.text = "￥" + model.price
        cell.brandLabel.text = self.brand_name
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let ww = (UIScreen.mainScreen().bounds.width - 10 * 3) / 2
        let hh = ww * 1.2
        return CGSizeMake(ww, hh)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let pvc = ProductViewController()
        let model = dataArray[indexPath.item] as! BrandListModel
        pvc.navigationController?.navigationBarHidden = true
        pvc.goodID = model.goods_id
        pvc.model = model
        self.navigationController?.pushViewController(pvc, animated: true)
    }
    
}
