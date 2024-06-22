//
//  UserDefaultsManager.swift
//  ToBuy
//
//  Created by Joy Kim on 6/15/24.
//

import UIKit

class UserDefaultManager {
    static let shared = UserDefaultManager()
    static var nickname: String {
        
        get {
            return UserDefaults.standard.string(forKey: "nickname") ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    static var profileImage: Int {
        get{
            return UserDefaults.standard.integer(forKey: "profileImage") 
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "profileImage")
        }
    }
    
    
    static var searchKeyword: [String] {
        get {
            return UserDefaults.standard.array(forKey: "searchKeyword") as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "searchKeyword")
        }
    }
    
    static var joinedDate: Date {
        get{
            return UserDefaults.standard.object(forKey: "joinedDate") as? Date ?? Date()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "joinedDate")
        }
    }
    
    static var likedItemID: [String] {
        get{
            return UserDefaults.standard.array(forKey: "likedItemId") as? [String] ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "likedItemId")
        }
    }
}
 extension UserDefaultManager {

   func clearUserDefaults() {
       let keys = ["nickname", "profileImage", "searchKeyword", "joinedDate", "likedItemId"]

        for i in keys {
            UserDefaults.standard.removeObject(forKey: i)
        }
           UserDefaults.standard.synchronize()
       }
}
