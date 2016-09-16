//
//  RefeashHeader.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import MJRefresh


class RefeshHeader: MJRefreshNormalHeader {
    
    override func placeSubviews() {
        
        super.placeSubviews()
        self.mj_y = -self.mj_h - self.ignoredScrollViewContentInsetTop - 80;
        
    }
    
}