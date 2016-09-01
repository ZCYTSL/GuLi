//
//  ManagerNetwork.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation


extension MagazineModel {
    
    class func requestData(callBack:(array1: [AnyObject]?,array2: [AnyObject]?,error: NSError?)->Void)->Void {
        //http://mobile.iliangcang.com/topic/magazineList/?&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C
        let urlStr = "http://mobile.iliangcang.com/topic/magazineList/"
        let para = ["app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C"]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let dic = obj["data"]!["items"] as! NSDictionary
                let dict = dic["infos"] as! NSDictionary
                let valueArray = NSMutableArray()
                for value in dict.allValues {
                    let arr = MagazineModel.arrayOfModelsFromDictionaries(value as! [AnyObject])
                    valueArray.addObject(arr)
                }
                let array = dic["keys"] as! [AnyObject]
                
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array1: valueArray as [AnyObject],array2: array, error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array1: nil,array2: nil, error: error)
                })
            }
        }
    }
    
}