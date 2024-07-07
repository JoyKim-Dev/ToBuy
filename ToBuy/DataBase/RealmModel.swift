//
//  RealmModel.swift
//  ToBuy
//
//  Created by Joy Kim on 7/7/24.
//

import Foundation
import RealmSwift

class LikedItemTable: Object {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted (indexed: true) var title: String
    @Persisted var price: String
    @Persisted var webLink: String
    @Persisted var image: String
    @Persisted var likedDate: Date

    convenience init(id: String, title: String, price: String, webLink: String, image: String) {
        self.init()
        self.id = id
        self.title = title
        self .price = price
        self.webLink = webLink
        self.image = image
        self.likedDate = Date()
   }
}
