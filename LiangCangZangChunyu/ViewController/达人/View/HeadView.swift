//
//  HeadView.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/9/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit


protocol HeadViewDelegate: class {
    func pushToViewController()->Void
    func click()->Void
}
class HeadView: UIView {
    
    weak var delegate: HeadViewDelegate?
    var backImage:UIImageView!
    var nameLabel:UILabel!
    var priceLabel:UILabel!
    var collectBtn:UIButton!
    var linkBtn:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor()
        self.userInteractionEnabled = true
        self.creatSubview()
    }
    
    func creatSubview() {
        backImage = UIImageView.init(frame: CGRectMake(20, 20, SCREEN_W - 40, 300))
        self.addSubview(backImage)
        nameLabel = UILabel.init(frame: CGRectMake(20, 330, SCREEN_W - 200, 30))
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.font = UIFont.systemFontOfSize(16)
        self.addSubview(nameLabel)
        priceLabel = UILabel.init(frame: CGRectMake(20, 360, SCREEN_W - 200, 30))
        priceLabel.textColor = UIColor.greenColor()
        priceLabel.font = UIFont.systemFontOfSize(16)
        self.addSubview(priceLabel)
        collectBtn = UIButton.init(frame: CGRectMake(300, 330, 60, 30))
        collectBtn.addTarget(self, action: #selector(self.collecButton(_:)), forControlEvents: .TouchUpInside)
        collectBtn.setTitle("收藏", forState: UIControlState.Normal)
        collectBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        collectBtn.setTitleColor(UIColor.init(red: 72/255.0, green: 187/255.0, blue: 246/255.0, alpha: 0.8), forState: UIControlState.Selected)
        self.addSubview(collectBtn)
        linkBtn = UIButton.init(frame: CGRectMake(300, 360, 50, 30))
        linkBtn.addTarget(self, action: #selector(self.linkButtonClick(_:)), forControlEvents: .TouchUpInside)
        linkBtn.setTitle("LINK", forState: UIControlState.Normal)
        linkBtn.setTitle("LINK", forState: UIControlState.Selected)
        linkBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        linkBtn.backgroundColor = UIColor.grayColor()
        self.addSubview(linkBtn)
        
    }
    
    func linkButtonClick(button:UIButton) {
        print("link")
        
        self.delegate?.pushToViewController()
    }
    
    func collecButton(button:UIButton) {
        self.delegate?.click()
        collectBtn.setTitle("已收藏", forState: UIControlState.Normal)
        collectBtn.userInteractionEnabled = false
        print("已收藏")
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}
