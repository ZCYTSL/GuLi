//
//  BrandManagerNetwork.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation



extension BrandListModel {
    
    class func requestBrandListData(brandID: NSNumber!,callBack:(array: [AnyObject]?, error: NSError?)->Void) {
        //http://mobile.iliangcang.com/brand/brandShopList?a=b&page=1&count=10&brand_id=14&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C
        let urlStr = "http://mobile.iliangcang.com/brand/brandShopList"
        let para = ["a":"b","page":"1","count":"10","brand_id":String(brandID),"app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C"]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let array = obj["data"]!["items"] as? [AnyObject]
                let modelArray = NSMutableArray()
                if array?.count > 0 {
                    let arr = BrandListModel.arrayOfModelsFromDictionaries(array)
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
    
    class func requestProductData(goodID:String!,callBack:(array:[AnyObject]?,error:NSError?)->Void){
        //http://mobile.iliangcang.com/goods/goodsDetail/?goods_id=34643&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C
        let urlStr = "http://mobile.iliangcang.com/goods/goodsDetail/"
        let para = ["app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C","goods_id":String(goodID)]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let Dic = obj["data"] as! NSDictionary
                let dic = Dic["items"] as! NSDictionary
                let array = dic["images_item"] as? [AnyObject]
                let imageArray = NSMutableArray()
                if array?.count > 0 {
                    imageArray.addObjectsFromArray(array!)
                }
                dispatch_async(dispatch_get_main_queue(), {
                callBack(array: imageArray as [AnyObject], error: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil, error: error)
                })
            }
        }

    }
}