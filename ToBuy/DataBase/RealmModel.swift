//
//  RealmModel.swift
//  ToBuy
//
//  Created by Joy Kim on 7/7/24.
//

import Foundation
import RealmSwift

class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var brandName: String
    @Persisted var regDate: Date
    @Persisted var detail: List<LikedItemTable>
    
    convenience init(brandName: String, detail: List<LikedItemTable> ) {
        self.init()

        self.brandName = brandName
        self.regDate = Date()
        self.detail = detail
    }
}

class LikedItemTable: Object {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted (indexed: true) var title: String
    @Persisted var price: String
    @Persisted var webLink: String
    @Persisted var brand: String
    @Persisted var image: String
    @Persisted var likedDate: Date
    @Persisted(originProperty: "detail") var main: LinkingObjects<Folder>
  
    convenience init(id: String, title: String, price: String, webLink: String, brand: String, image: String) {
        self.init()
        self.id = id
        self.title = title
        self .price = price
        self.webLink = webLink
        self.brand = brand
        self.image = image
        self.likedDate = Date()
   }
}
