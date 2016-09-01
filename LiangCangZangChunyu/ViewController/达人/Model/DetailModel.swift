//
//  DetailModel.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation


class RecommendedModel: JSONModel {
    
    var comment_count: String!
    var goods_id: String!
    var goods_image: String!
    var goods_name: String!
    var is_outter: String!
    var like_count: String!
    var liked: String!
    var owner_id: String!
    var price: String!
}


class DetailsModel: JSONModel {
    
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
    var users: NSMutableArray?
    
    required init(dictionary dict: [NSObject : AnyObject]!) throws {
        super.init()
        self.setValuesForKeysWithDictionary(dict as! [String:AnyObject])
        let array = dict["users"] as? [AnyObject]
        self.users = nil
        self.users = NSMutableArray()
        if array?.count > 0 {
            let arr = UserModel.arrayOfModelsFromDictionaries(array)
            self.users?.addObjectsFromArray(arr as [AnyObject])
        }
    }
    
    required init(data: NSData!) throws {
        fatalError("init(data:) has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}

class UserModel: JSONModel {
    var is_daren: String!
    var user_desc: String!
    var user_id: String!
    var user_image: NSDictionary?
    var user_name: String!
    
}

class GoodsModel: JSONModel{
    var comment_count: String!
    var goods_desc: String!
    var goods_id: String!
    var goods_image: String!
    var goods_name: String!
    var goods_url: String!
    var headimg: String!
    var images_item: NSMutableArray!
    var is_daren: String!
    var is_gift: String!
    var is_sold_out: String!
    var like_count: String!
    var liked: String!
    var owner_desc: String!
    var owner_id: String!
    var owner_name: String!
    var price: String!
    var rec_reason: String!
    var sku_inv: String!
    var sold_out_img_url: String!
    
}

class CommentModel: JSONModel {
    var comment_id: NSNumber!
    var create_time: String!
    var goods_id: NSNumber!
    var is_daren: String!
    var msg: String!
    var parent_id: NSNumber!
    var parent_uid: String!
    var parent_user_image: String!
    var parent_user_name: String!
    var user_id: NSNumber!
    var user_image: String!
    var user_name: String!

    
}






