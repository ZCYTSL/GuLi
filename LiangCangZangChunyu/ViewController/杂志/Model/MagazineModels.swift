//
//  MagazineModels.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import JSONModel

class MagazineModel: JSONModel {
    var access_url: String!
    var addtime: String!
    var author_id: String!
    var author_name: String!
    var cat_id: String!
    var cat_name: String!
    var content: String!
    var cover_img: String!
    var cover_img_new: String!
    var hit_number: NSNumber!
    var nav_title: String!
    var taid: String!
    var topic_name: String!
    var topic_url: String!
}