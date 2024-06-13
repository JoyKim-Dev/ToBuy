//
//  NicknameTextField.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

class NicknameTextField:UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        
        backgroundColor = Color.orange
        layer.cornerRadius = 20
        
        borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: frame.size.height-1, width: frame.width, height: 1)
        border.backgroundColor = Color.mediumGray.cgColor
        layer.addSublayer((border))
        textAlignment = .left
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : Color.mediumGray])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
