//
//  ShopTitleView.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

protocol ShopTitleViewDelegate: class {
    func titleDidSelectedAtIndex(index: NSInteger)->Void
}

class ShopTitleView: UIView {
    let leftSpace: CGFloat = 0
    let topSpace: CGFloat = 10
    let btnHeight: CGFloat = 23
    var btnWidth: CGFloat = 0
    var sliderView: UIView!
    var selectedIndex: NSInteger = 0    //记录上次被选中
    weak var delegate: ShopTitleViewDelegate?
    
    init(frame: CGRect, titleArray: [String]) {
        super.init(frame: frame)
        self.creatSubviews(titleArray)
    }
    
    func creatSubviews(titleArray: [String]) -> Void {
        btnWidth = (SCREEN_W - 2 * leftSpace) / CGFloat(titleArray.count)
        var i = 0
        for title in titleArray {
            let btn = UIButton.init(frame: CGRectMake(btnWidth * CGFloat(i), topSpace, btnWidth, btnHeight))
            btn.setTitle(title, forState: UIControlState.Normal)
            btn.setTitleColor(TEXTGRYCOLOR, forState: UIControlState.Normal)
            btn.setTitleColor(TEXTGRYCOLOR, forState: UIControlState.Highlighted)
            btn.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
            btn.tag = i + 100
            btn.addTarget(self, action: #selector(self.titleDidClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(btn)
            i += 1
        }
        
        sliderView = UIView.init(frame: CGRectMake(0, self.frame.size.height - 3, btnWidth, 3))
        sliderView.backgroundColor = UIColor.blackColor()
        self.addSubview(sliderView)
    }
    
    func titleDidClicked(button: UIButton) -> Void {
        
        self.setIndex(button.tag - 100)
        self.delegate?.titleDidSelectedAtIndex(button.tag - 100)
    }
    
    func setIndex(index: NSInteger) -> Void {
        
        let perBtn = self.viewWithTag(100 + self.selectedIndex) as! UIButton
        perBtn.setTitleColor(TEXTGRYCOLOR, forState: UIControlState.Normal)
        perBtn.setTitleColor(TEXTGRYCOLOR, forState: UIControlState.Highlighted)
        
        let button = self.viewWithTag(100 + index) as! UIButton
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        selectedIndex = index
        
        UIView.animateWithDuration(0.20) {
            self.sliderView.mj_x = CGFloat(self.selectedIndex) * self.btnWidth
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}