//
//  Recipe.swift
//  recipeapp
//
//  Created by yuki hiruma on 2022/08/07.
//

import RealmSwift

class Recipe: Object{
    //管理用ID プライマリーキー
    @objc dynamic var id = 0
    
    //レシピ名
    @objc dynamic var title = ""
    
    //ひとことメモ
    @objc dynamic var memo = ""
    
    //材料/手順
    @objc dynamic var process = ""
    
    //写真
    @objc dynamic var image: Data? = nil
    
    //管理用IDをプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
}
