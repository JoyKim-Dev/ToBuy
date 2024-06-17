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
            return UserDefaults.standard.string(forKey: "nickname") ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    static var profileImage: [Int] {
        get{
            return UserDefaults.standard.array(forKey: "profileImage") as? [Int] ?? [0]
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
    
}

