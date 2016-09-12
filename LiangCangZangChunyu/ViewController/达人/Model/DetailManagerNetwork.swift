//
//  DetailManagerNetwork.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation


extension RecommendedModel {
    
    class func requestData(page: NSInteger,usid: String!, callBack:(array: [AnyObject]?,error: NSError?)->Void) {
        //http://mobile.iliangcang.com/user/masterListInfo/?&count=10&owner_id=12596&page=1&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C
        let urlStr = "http://mobile.iliangcang.com/user/masterListInfo/"
        let para = ["count":"10","owner_id":usid,"page":String(page),"app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C"]
        
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let Dic = obj["data"]!["items"] as! NSDictionary
                let array = Dic["goods"] as? [AnyObject]
                let modelArray = NSMutableArray()
                if array?.count > 0 {
                    let arr = RecommendedModel.arrayOfModelsFromDictionaries(array)
                    modelArray.addObjectsFromArray(arr as [AnyObject])
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: modelArray as [AnyObject], error: nil)
                })
                
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil, error: error)
                })
            }
        }
    }
}

extension DetailsModel {
    
    class func requestUserData(page: NSInteger!,usid: String!,callBack:(array: [AnyObject]?, imageArray: [AnyObject]?, error: NSError?)->Void) {
        //http://mobile.iliangcang.com/user/masterFollow/?&count=10&owner_id=12596&page=1&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C
        let urlStr = "http://mobile.iliangcang.com/user/masterFollow/"
        let para = ["count":"10","owner_id":usid,"page":String(page),"app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C"]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let Dic = obj["data"]!["items"] as! NSDictionary
                let array = Dic["users"] as? [AnyObject]
                let modelArray = NSMutableArray()
                let imageArray = NSMutableArray()
                let userArray = NSMutableArray()
                if array?.count > 0 {
                    let arr = UserModel.arrayOfModelsFromDictionaries(array)
                    modelArray.addObjectsFromArray(arr as [AnyObject])
                    
                    for model in array! {
                        let userimage = model["user_image"] as! NSDictionary
                        imageArray.addObject(userimage)
                    }
                    let arr1 = ImageModel.arrayOfModelsFromDictionaries(imageArray as [AnyObject])
                    userArray.addObjectsFromArray(arr1 as [AnyObject])
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: modelArray as [AnyObject],imageArray: userArray as [AnyObject], error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil,imageArray: nil, error: error)
                })
            }
        }
    }
    
    class func requestFansData(page: NSInteger!,usid: String!,callBack:(array: [AnyObject]?, imageArray: [AnyObject]?, error: NSError?)->Void) {
        //http://mobile.iliangcang.com/user/masterFollowed/?&count=10&owner_id=12596&page=1&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C
        let urlStr = "http://mobile.iliangcang.com/user/masterFollowed/"
        let para = ["count":"10","owner_id":usid,"page":String(page),"app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C"]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let Dic = obj["data"]!["items"] as! NSDictionary
                let array = Dic["users"] as? [AnyObject]
                let modelArray = NSMutableArray()
                let imageArray = NSMutableArray()
                let userArray = NSMutableArray()
                if array?.count > 0 {
                    let arr = UserModel.arrayOfModelsFromDictionaries(array)
                    modelArray.addObjectsFromArray(arr as [AnyObject])
                    
                    for model in array! {
                        let userimage = model["user_image"] as! NSDictionary
                        imageArray.addObject(userimage)
                    }
                    let arr1 = ImageModel.arrayOfModelsFromDictionaries(imageArray as [AnyObject])
                    userArray.addObjectsFromArray(arr1 as [AnyObject])
                }
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: modelArray as [AnyObject],imageArray: userArray as [AnyObject], error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: nil,imageArray: nil, error: error)
                })
            }
        }
    }
    
}

//推荐书籍展示页
extension GoodsModel{
    
    class func requestGoodsData(goodsId: String,callBack:(s1: String?,s2: String?,s3:String?,s4:String?, error: NSError?)->Void) {
        //http://mobile.iliangcang.com/goods/goodsDetail/?uid=160111931&goods_id=245068&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C&user_token=3d8310797a27fa7fe1fad310d12da37b
        let urlStr = "http://mobile.iliangcang.com/goods/goodsDetail/"
        let para = ["goods_id": goodsId,"app_key":"iPhone","v":"3.0.0","sig":"sig=13D69254-786A-42F1-B9D2-575BFDD67E7C"]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let dic = obj["data"]!["items"] as! NSDictionary
                let aa = dic["goods_name"] as! String
                let bb = dic["goods_url"] as! String
                let cc = dic["goods_image"] as! String
                let dd = dic["price"] as! String
                
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(s1: aa, s2: bb, s3: cc,s4: dd, error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(s1: nil, s2: nil, s3: nil,s4:nil,  error: error)
                })
            }
        }
    }
}

//评论数据
extension CommentModel {
    class func requestData(page: NSInteger!,goodsId: String!,callBack:(array: [AnyObject]?,error: NSError?)->Void) {
        //http://mobile.iliangcang.com/comments/goods?a=b&page=1&count=10&goods_id=245068&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C&user_token=3d8310797a27fa7fe1fad310d12da37b
        let urlStr = "http://mobile.iliangcang.com/comments/goods"
        let para = ["a":"b","page":String(page),"count":"10","goods_id":goodsId,"app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C"]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let array = obj["data"]!["items"] as? [AnyObject]
                let modelArray = NSMutableArray()
                if array?.count > 0 {
                    let arr = CommentModel.arrayOfModelsFromDictionaries(array)
                    modelArray.addObjectsFromArray(arr as [AnyObject])
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: modelArray as [AnyObject], error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil, error: error)
                })
            }
        }
    }
}




