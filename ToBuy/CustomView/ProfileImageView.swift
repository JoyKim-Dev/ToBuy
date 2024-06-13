//
//  ProfileImageView.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

enum ImageBorderWidth: CGFloat {
    case isSelected = 3
    case unSelected = 1
}

//enum ImageBorderColor {
//    static let selectedBorderColor = Color.orange.cgColor
//    static let unSelectedBorderColor = Color.unselectedGray.cgColor
//}

class ProfileImageView: UIImageView {
    
    init(profileImageNum: Int, borderWidth: ImageBorderWidth) {
        super.init(frame: .zero)
        
        image = UIImage(named: "profile_\(profileImageNum)")
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        layer.borderWidth = borderWidth.rawValue
        layer.borderColor = Color.orange.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
