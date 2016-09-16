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
        let createSql = "create table if not exists userInfo(id integer primary key autoincrement, name varchar(256))"
        do {
            try fmdb.executeUpdate(createSql, values: nil)
        } catch {
            print(fmdb.lastErrorMessage())
        }
    }
    
    func insertWith(model: RecommendedModel) -> Void {
        let insertSql = "insert into userInfo(name) values(?)"
        do {
            try fmdb.executeUpdate(insertSql, values: [model.goods_name!])
        } catch {
            print(fmdb.lastErrorMessage())
        }
    }
    
    func updateWith(model: RecommendedModel, uid: Int) -> Void {
        let updateSql = "update userInfo set name = ?, where id = ?"
        
        do {
            try fmdb.executeUpdate(updateSql, values: [model.goods_name!,uid])
        } catch {
            print(fmdb.lastErrorMessage())
            
        }
    }
    
    func selectAll() -> [RecommendedModel] {
        
        var tmpArr = [RecommendedModel]()
        let selectSql = "select * from userInfo"
        do {
            let rs = try fmdb.executeQuery(selectSql, values: nil)
            while rs.next() {
                let model = RecommendedModel()
                tmpArr.append(model)
            }
        } catch {
            print(fmdb.lastErrorMessage())
        }
        return tmpArr
    }

}
