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
  
    }
