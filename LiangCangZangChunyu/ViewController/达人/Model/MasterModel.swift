//
//  MasterModel.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

class MasteModel: JSONModel {
    
    var duty: String!
    var is_daren: String!
    var nickname: String!
    var uid: String!
    var user_images: NSDictionary!
    var username: String!

}


class ImageModel: JSONModel {
    var mid: String!
    var orig: String!
    var self_img: String!
    var tmb: String!
    
}

//达人详情页

class MasterDetailModel: JSONModel {
    
    var email: String!
    var followed_count: String!
    var following_count: String!
    var friend: String!
    var is_daren: String!
    var like_count: String!
    var recommendation_count: String!
    var template_id: String!
    var user_desc: String!
    var user_id: String!
    var user_image: NSDictionary!
    var user_name: String!
    
}









