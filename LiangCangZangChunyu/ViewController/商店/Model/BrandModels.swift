//
//  BrandModels.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import JSONModel

class BrandListModel: JSONModel {
    
    var brand_info: NSDictionary!
    var comment_count: String!
    var discount_price: String!
    var goods_id: String!
    var goods_image: String!
    var goods_name: String!
    var goods_url: String!
    var is_gift: String!
    var like_count: String!
    var liked: String!
    var owner_id: String!
    var price: String!
    var promotion_imgurl: String!
    var sale_by: String!
}

class infoModel: JSONModel {
    
    var brand_desc: String!
    var brand_id: String!
    var brand_logo: String!
    var brand_name: String!
}






