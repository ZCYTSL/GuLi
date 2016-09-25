//
//  DataManager.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/9/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import FMDB

class DataManager: NSObject {
    
    static let defaultManager = DataManager()
    let fmdb: FMDatabase
    
    override init() {
        
        let path = NSHomeDirectory().stringByAppendingString("/Documents/zcyGuLi.db")
        fmdb = FMDatabase.init(path: path)
        if !fmdb.open() {
            print("open error")
            return
        }
        let createSql = "create table if not exists collect(id integer primary key autoincrement, name text, price text, image text)"
        do {
            try fmdb.executeUpdate(createSql, values: nil)
        } catch {
            print(fmdb.lastErrorMessage())
        }
    }
    
    func insertWith(model: RecommendedModel) -> Void {
        let insertSql = "insert into collect(name, price, image) values(?, ?, ?)"
        do {
            try fmdb.executeUpdate(insertSql, values: [model.goods_name!,model.price!,model.goods_image!])
        } catch {
            print(fmdb.lastErrorMessage())
        }
    }
    
    func updateWith(model: RecommendedModel, uid: Int) -> Void {
        let updateSql = "update collect set name = ?, price = ?, image = ? where id = ?"
        
        do {
            try fmdb.executeUpdate(updateSql, values: [model.goods_name!,model.price!,model.goods_image,uid])
        } catch {
            print(fmdb.lastErrorMessage())
            
        }
    }
    
    func selectAll() -> [RecommendedModel] {
        
        var tmpArr = [RecommendedModel]()
        let selectSql = "select * from collect"
        do {
            let rs = try fmdb.executeQuery(selectSql, values: nil)
            while rs.next() {
                let model = RecommendedModel()
                model.goods_name = rs.stringForColumn("name")
                model.price = rs.stringForColumn("price")
                model.goods_image = rs.stringForColumn("image")
                tmpArr.append(model)
            }
        } catch {
            print(fmdb.lastErrorMessage())
        }
        return tmpArr
    }
    func remove(model:RecommendedModel) {
        let removcSql = "remove from collect where id = ?"
        do {
            try fmdb.executeUpdate(removcSql, values: nil)
        } catch {
            print(fmdb.lastErrorMessage())
        }
    }

}
