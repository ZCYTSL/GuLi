//
//  ShopNetworkManager.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation



extension SliderModel {
    
    class func requestShopData(callBack:(imageArray: [AnyObject]?,array: [AnyObject]?, error: NSError?)->Void)->Void {
//   http://mobile.iliangcang.com/goods/shopHome?a=b&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C        
        let urlStr = "http://mobile.iliangcang.com/goods/shopHome"
        let para = ["a":"b","app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C"]
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
//                let str = NSString.init(data: data!, encoding: NSUTF8StringEncoding)
//                print(str!)
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let Dic = obj["data"]!["items"] as! NSDictionary
                
                //slide的数据
                let array = Dic["slide"] as? [AnyObject]
                let imageArray = NSMutableArray()
                if array?.count > 0 {
                    for dic in array! {
                        let image = dic["pic_url"] as! String
                        imageArray.addObject(image)
                    }
//                    let arr = SliderModel.arrayOfModelsFromDictionaries(array)
//                    modelArray.addObjectsFromArray(arr as [AnyObject])
                }
                
                //list-tableview的数据
                let arr = Dic["list"] as? [AnyObject]
                let listArray = NSMutableArray()
                let valueArray = NSMutableArray()
                if arr?.count > 0 {
                    for dict in arr! {
//                        dict as! NSDictionary
                        
                        dict.removeObjectsForKeys(["home_id","home_type","order_num"])
                        for value in dict.allValues {
                            valueArray.addObject(value)
                        }
                    }
                    let arrrr = listModel.arrayOfModelsFromDictionaries(valueArray as [AnyObject])
                    listArray.addObjectsFromArray(arrrr as [AnyObject])
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(imageArray: imageArray as [AnyObject],array: listArray as [AnyObject] , error: nil)
                })
                
            } else {
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(imageArray: nil,array: nil, error: error)
                })
            }
        }
    }
}

extension BrandModel {
    
    class func requestBrandData(page: NSInteger!,callBack:(array: [AnyObject]?, error: NSError?)->Void)->Void {
//        http://mobile.iliangcang.com/brand/brandList/?page=1&count=20&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C
        
        let urlStr = "http://mobile.iliangcang.com/brand/brandList/"
        let para = NSMutableDictionary.init(dictionary: ["page":String(page),"count":"20","app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C"])
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
//                let str = NSString.init(data: data!, encoding: NSUTF8StringEncoding)
//                print(str!)
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                let dic = obj["data"] as! NSDictionary
                let array = dic["items"] as? [AnyObject]
                
                let modelArray = NSMutableArray()
                if array?.count > 0 {
                    let arr = BrandModel.arrayOfModelsFromDictionaries(array)
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


extension SpecialModel {
    class func requestSpecialData(page: NSInteger!,callBack:(array: [AnyObject]?,error: NSError?)->Void)->Void {
//        http://mobile.iliangcang.com/goods/shopSpecial/?page=1&count=5&app_key=iPhone&v=3.0.0&sig=13D69254-786A-42F1-B9D2-575BFDD67E7C
        let urlStr = "http://mobile.iliangcang.com/goods/shopSpecial/"
        let para = NSMutableDictionary.init(dictionary: ["page":String(page),"count":"5","app_key":"iPhone","v":"3.0.0","sig":"13D69254-786A-42F1-B9D2-575BFDD67E7C"])
        BaseRequest.getWithURL(urlStr, para: para) { (data, error) in
            if error == nil {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let dic = obj["data"] as! NSDictionary
                let array = dic["items"] as? [AnyObject]
                let modelArray = NSMutableArray()
                if array?.count > 0 {
                    let arr = SpecialModel.arrayOfModelsFromDictionaries(array)
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







