//
//  ShopModels.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation


class SliderModel: JSONModel {
    
    var content_id: String!
    var content_type: String!
    var order_num: String!
    var pic_url: String!
    var slide_id: String!
    var topic_name: String!
    var topic_url: String!
    
}

class valueMdoel: JSONModel {
    var one: NSDictionary!
    var two: NSDictionary?
    var three: NSDictionary?
    var four: NSDictionary?
}

class listModel: JSONModel {
    var content_id: String!
    var content_type: String!
    var home_id: String!
    var pic_url: String!
    var pos: String!
    var topic_name: String!
    var topic_url: String!
}

class BrandModel: JSONModel {
    var brand_id: NSNumber!
    var brand_logo: String!
    var brand_name: String!
    
}


class SpecialModel: JSONModel {
    var access_url: String!
    var addtime: String!
    var author_id: String!
    var cat_id: String!
    var cat_name: String!
    var cover_img: String!
    var cover_img_new: String!
    var goods_number: String!
    var hit_number: String!
    var img_path: String!
    var is_published: String!
    var is_show_list: String!
    var publish_time: String!
    var publish_type: String!
    var taid: String!
    var topic_name: String!
    var topic_url: String!
}
