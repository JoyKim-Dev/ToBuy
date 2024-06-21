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
    
    static var storedDataisChanged: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "dataChanged")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "dataChanged")
        }
    }
    
    static var totalLikeCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "totalLike")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "totalLike")
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
    
    static var keyHistoryArray: [String] {
        get {
            return UserDefaults.standard.array(forKey: "totalKey") as? [String] ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "totalKey")
        }
    }
  
}

extension UserDefaultManager {
    
    func countLikedItems() -> Int {
         var likedCount = 0
         
             let keyArray = UserDefaultManager.keyHistoryArray
        
        for key in keyArray{
             let liked = UserDefaults.standard.bool(forKey: key)
             if liked {
                 likedCount += 1
             }
         }
         print(likedCount)
         return likedCount
     }
    
   func clearUserDefaults() {
        var keys = ["nickname", "profileImage", "searchKeyword", "totalLike", "joinedDate"]
        keys.append(contentsOf: UserDefaultManager.keyHistoryArray)
       
        for i in keys {
            UserDefaults.standard.removeObject(forKey: i)
        }
           UserDefaults.standard.synchronize()
       }
}
