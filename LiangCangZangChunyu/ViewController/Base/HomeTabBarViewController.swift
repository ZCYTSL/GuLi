//
//  HomeTabBarViewController.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.creatViewControllers()
        
    }
    
    func creatViewControllers() -> Void {
        
        let shopVC = ShopViewController()
        let MagazineVC = MagazineViewController()
        let MasterVC = MasterViewController()
//        let shareVC = ShareViewController()
        let userVC = UserViewController()
        
        let controllers = [shopVC,MagazineVC,MasterVC,userVC]
        let titleArray = ["商店","杂志","达人","个人"]
        
        var navArray = [UINavigationController]()
        var i = 0
        for vc in controllers {
            let nav = UINavigationController.init(rootViewController: vc)
            let image = UIImage.init(named: titleArray[i])?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            let image1 = UIImage.init(named: titleArray[i] + "selected")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            let tabBarItem = UITabBarItem.init(title: titleArray[i], image: image, selectedImage: image1)
            tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12)], forState: .Normal)
            tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12),NSForegroundColorAttributeName: UIColor.blackColor()], forState: .Selected)
            nav.tabBarItem = tabBarItem
            nav.navigationBar.barTintColor = UIColor.init(red: 0.5, green: 1.0, blue: 0.9, alpha: 0.1)
            navArray.append(nav)
            i += 1
        }
        self.viewControllers = navArray
        self.tabBar.barTintColor = UIColor.init(red: 0.5, green: 1.0, blue: 0.9, alpha: 0.1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
