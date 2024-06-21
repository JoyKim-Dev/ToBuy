//
//  Resource.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

enum Icon {
    static let search = UIImage(systemName: "magnifyingglass")
    static let person = UIImage(systemName: "person")
    static let clock = UIImage(systemName: "clock")
    static let chevronRight = UIImage(systemName: "chevron.right")
    static let chevronLeft = UIImage(systemName: "chevron.left")
    static let xMark = UIImage(systemName: "xmark")
    static let cameraFill = UIImage(systemName: "camera.fill")
    static let likeSelected = UIImage(named: "like_selected")!.withRenderingMode(.alwaysOriginal)
    static let likeUnSelected = UIImage(named: "like_unselected")!.withRenderingMode(.alwaysOriginal)
    
}

enum Color {
    
    static let orange = UIColor(red: 0.94, green: 0.54, blue: 0.28, alpha: 1.00)
    static let black = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    static let darkGray = UIColor(red: 0.30, green: 0.30, blue: 0.30, alpha: 1.00)
    static let mediumGray = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00)
    static let lightGray = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.00)
    static let unselectedGray = Color.lightGray.withAlphaComponent(0.5)
    static let white = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
}

enum ImageBorderWidth: CGFloat {
    case isSelected = 3
    case unSelected = 1
    
    mutating func toggle() {
        switch self {
        case.isSelected:
            self = .unSelected
        case.unSelected:
            self = .isSelected
        }
    }
}

enum ImageAlpha: CGFloat {
    case isSelected = 1
    case unSelected = 0.5
    
    mutating func toggle() {
        switch self {
        case.isSelected:
            self = .unSelected
        case.unSelected:
            self = .isSelected
        }
    }
}

enum ImageBorderColor {
    case isSelected
    case unSelected
    
   
    var value: CGColor {
        switch self {
        case .isSelected:
            return Color.orange.cgColor
        case.unSelected:
            return Color.unselectedGray.cgColor
        }
    }
    
    mutating func toggle() {
        switch self {
        case.isSelected:
            self = .unSelected
        case.unSelected:
            self = .isSelected
        }
    }
}

enum Font {
    
    static let semiBold13 = UIFont.systemFont(ofSize: 13, weight: .semibold)
    static let semiBold14 = UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let semiBold15 = UIFont.systemFont(ofSize: 15, weight: .semibold)
    static let semiBold16 = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    static let heavy15 = UIFont.systemFont(ofSize: 15, weight: .heavy)
    static let heavy20 = UIFont.systemFont(ofSize: 20, weight: .heavy)
    
    static let appTitleFont = UIFont.systemFont(ofSize: 50, weight: .black)
    

}

enum Image {
    static let mainImage = UIImage(named: "toBuyMainIcon")
    static let emptyImage = UIImage(named: "emptyBag")
}





    
