//
//  UserDefaultsManager.swift
//  ToBuy
//
//  Created by Joy Kim on 6/15/24.
//

import UIKit




class UserDefaultManager {
    
    static var nickname: String {
        
        get {
            return UserDefaults.standard.string(forKey: "nickname") ?? "미정"
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
    
    
    static var searchKeyword: [Any] {
        get {
            return UserDefaults.standard.array(forKey: "searchKeyword") ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "searchKeyword")
        }
    }
}

