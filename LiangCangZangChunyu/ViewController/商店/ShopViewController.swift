//
//  ShopViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit


protocol ShopDelegate: class {
    func pushToViewController(vc: UIViewController)->Void
}
class ShopViewController: UIViewController, ShopTitleViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,ShopDelegate,UISearchResultsUpdating {
    
    var titleView: ShopTitleView!
    var collectionView: UICollectionView!
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "商店"
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "left"), style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.searchWith))
        
        searchController = UISearchController.init(searchResultsController: nil)
        searchController?.hidesNavigationBarDuringPresentation = true
        searchController?.hidesBottomBarWhenPushed = true
        searchController?.searchResultsUpdater = self
        searchController?.dimsBackgroundDuringPresentation = true
        searchController?.searchBar.searchBarStyle = .Prominent
        searchController?.searchBar.sizeToFit()
        
        self.creatCollectionView()
        self.creatTitleView()
        titleView.setIndex(1)
        
    }
    func searchWith() {
        self.presentViewController(searchController!, animated: true, completion: nil)
        self.becomeFirstResponder()
        
    }
    
    func creatTitleView() -> Void {
        titleView = ShopTitleView.init(frame: CGRectMake(0, 64, SCREEN_W, 44), titleArray: ["品牌","首页","专题"])
        titleView.backgroundColor = UIColor.init(red: 0.5, green: 1.0, blue: 0.9, alpha: 0.7)
        titleView.delegate = self
        self.view.addSubview(titleView)
    }
    func titleDidSelectedAtIndex(index: NSInteger) {
        collectionView.contentOffset = CGPointMake(CGFloat(index)*SCREEN_W, 0)
    }
    
    func creatCollectionView() -> Void {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        collectionView = UICollectionView.init(frame: CGRectMake(0, 108, SCREEN_W, SCREEN_H - 108 - 49), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.backgroundColor = TEXTGRYCOLOR
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.pagingEnabled = true
        collectionView.contentOffset = CGPointMake(SCREEN_W * 1, 0)
        
        collectionView.registerClass(BrandView.self, forCellWithReuseIdentifier: "BrandView")
        collectionView.registerClass(HomeView.self, forCellWithReuseIdentifier: "HomeView")
        collectionView.registerClass(SpecialView.self, forCellWithReuseIdentifier: "SpecialView")
        
        self.view.addSubview(collectionView)
    }
    
    //MARK:---collectionview的协议方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BrandView", forIndexPath: indexPath) as! BrandView
            cell.delegate = self
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeView", forIndexPath: indexPath) as! HomeView
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SpecialView", forIndexPath: indexPath) as! SpecialView
            cell.delegate = self
            return cell
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(SCREEN_W, SCREEN_H - 108 - 49)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / SCREEN_W
        titleView.setIndex(NSInteger(index))
    }
    
    func pushToViewController(vc: UIViewController) {
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:---搜索框的协议方法
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
}













