//
//  MasterManagerNetwork.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation


extension MasteModel {
    
    class func requestData(page: NSInteger!,callBack:(array: [AnyObject]?, imageArray: [AnyObject]?, error: NSError?)->Void)->Void {
        //http://mobile.iliangcang.com/user/masterList/?&count=20&page=2&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C
        let urlStr = "http://mobile.iliangcang.com/user/masterList/"
        let para = ["count":"20","page": String(page),"app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C"]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let dic = obj.valueForKey("data") as! NSDictionary
                let array = dic.valueForKey("items") as? [AnyObject]
                let modelArray = NSMutableArray()
                let imageArray = NSMutableArray()
                if array?.count > 0 {
                    let arr = MasteModel.arrayOfModelsFromDictionaries(array)
                    modelArray.addObjectsFromArray(arr as [AnyObject])
                    for ddd in array! {
                        let dicArray = NSMutableArray()
                        let imagedic = ddd["user_images"] as! NSDictionary
                        dicArray.addObject(imagedic)
                        let arr = ImageModel.arrayOfModelsFromDictionaries(dicArray as [AnyObject])
                        imageArray.addObjectsFromArray(arr as [AnyObject])
                    }
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: modelArray as [AnyObject],imageArray: imageArray as [AnyObject], error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil,imageArray: nil, error: error)
                })
            }
        }
    }
}

extension MasterDetailModel {
    
    class func requestData(page: NSInteger!,usid: String!,callBack:(array: [AnyObject]?, error: NSError?)->Void)->Void {
        
        //http://mobile.iliangcang.com/user/masterLike/?&count=10&owner_id=12596&page=1&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C
        let urlStr = "http://mobile.iliangcang.com/user/masterLike/"
        let para = ["count":"10","owner_id":usid,"page":String(page),"app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C"]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let Dic = obj["data"] as! NSDictionary
                let dic = Dic["items"] as! NSDictionary
                let dicArray = NSMutableArray()
                let modelArray = NSMutableArray()
                dicArray.addObject(dic)
                let arr = MasterDetailModel.arrayOfModelsFromDictionaries(dicArray as [AnyObject])
                modelArray.addObjectsFromArray(arr as [AnyObject])
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


















